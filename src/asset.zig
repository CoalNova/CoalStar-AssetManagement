const std = @import("std");

/// Example Asset
/// Will need to handle init/deinit as assets may also be users for more assets
pub const Asset = struct {
    subscribers: u64 = 0,
    asset_id: u64 = 0,
};

/// The max size of the free_stack
const stack_cap: usize = 128;

/// The collection of loaded and/or unreleased assets
var assets: std.ArrayList(Asset) = undefined;
var free_stack: [stack_cap]usize = [_]usize{0} ** stack_cap;
var free_size: usize = 0;

pub fn init(allocator: std.mem.Allocator) void {
    assets = std.ArrayList(Asset).init(allocator);
}

pub fn deinit() void {
    assets.deinit();
}

/// Returns asset at given index provided on creation, should be treated as a temporary when used
/// Compiled assembly indicates this should be as few ops as exposing the collection
pub fn peekAsset(collection_index: usize) *Asset {
    return &assets.items[collection_index];
}

/// Returns the index of an asset, which is loaded or handled as needed
pub fn fetchAsset(asset_id: usize) usize {
    for (assets.items, 0..) |*asset, index|
        if (asset.asset_id == asset_id) {

            //if item was set to be cleared, it will need to be removed from the free_stack before being used again
            if (asset.subscribers == 0) {
                remove_free_block: for (0..free_size) |i| {
                    {
                        if (assets.items[free_stack[i]].asset_id == asset_id) {
                            //swap last to current if current is not last, should catch stack of size 1 problems
                            if (i < free_size - 1)
                                free_stack[i] = free_stack[free_size - 1];
                            break :remove_free_block;
                        }
                    }
                }
                free_size -= 1;
            }
            asset.subscribers += 1;
            return index;
        };

    return createAsset(asset_id);
}

/// Marks the asset as no longer in use by the user which requested it
pub fn releaseAsset(index: usize) void {
    assets.items[index].subscribers -|= 1;
    if (assets.items[index].subscribers == 0 and free_size < stack_cap) {
        free_stack[free_size] = index;
        free_size += 1;
    }
    // NOTE Clean in appearance, this will lead to distasterous results if
    // not verified. Assumptiveness here gives speed, but if an asset was
    // overwritten early, due to mishandling, further removals would cascade to
    // any new entry. A solution should be health checks, which periodically
    // and serially match states of users to asset ids to asset collection to
    // verify correctness. However, a system which would travel upwards through
    // pointers to verify a match of asset ID's would be very costly at this
    // level, a safer proposition would be handling it at the asset-user level
    // via periodic checks or a check when calling the asset in for processing.
}

/// Creates new instance of an asset which does not yet exist
fn createAsset(asset_id: usize) usize {
    // asset loading go here
    var asset = Asset{
        .asset_id = asset_id,
        .subscribers = 1,
    };

    // check if stack reveals out-of-use assets to overwrite before adding mem
    if (free_size > 0) {
        var free_index = free_size - 1;
        while (free_index > 0) : (free_index -= 1) {
            //start at the end and work our way back ?
            const asset_index = free_stack[free_size - (free_index + 1)];
            if (assets.items[asset_index].subscribers == 0) {

                //Asset deinitialization should occur

                assets.items[asset_index] = asset;
                free_size = free_index - 1;
                return asset_index;
            }
        }
        free_size = free_index;
    }

    // otherwise check collection the hard way
    for (assets.items, 0..) |entry, index|
        if (entry.subscribers == 0) {

            //Asset deinitialization should occur

            assets.items[index] = asset;
            return index;
        };

    // else append asset to end of collection, resizing if necessary
    assets.append(asset) catch |err| {
        std.debug.print("assets append error: {!}\n", .{err});
        return 0; //0 is default fallback
    };

    // give back the index
    return assets.items.len - 1;
}
