const std = @import("std");

/// Example Asset
pub const Asset = struct {
    subscribers: u64 = 0,
    asset_id: u64 = 0,
};

var assets: std.ArrayList(Asset) = undefined;
var free_stack: [64]usize = [_]usize{0} ** 64;
var free_size: usize = 0;

pub fn peekAsset(collection_index: usize) Asset {}

pub fn fetchAsset(asset_id: usize) usize {
    for (assets.items, 0..) |*asset, index|
        if (asset.asset_id == asset_id) {
            asset.subscribers += 1;
            return index;
        };

    return createAsset(asset_id);
}

pub fn releaseAsset(index: usize) void {
    assets.items[index].subscribers -|= 1;
    // NOTE Clean in appearance, this will lead to distasterous results if
    // not checked. Assumptiveness here gives speed, but if an entry was
    // overwritten early, it would cascade to any new entry. A solution should
    // be health checks, which periodically and serially match states of users
    // and asset ids to asset collection to verify correctness.
}

fn createAsset(asset_id: usize) usize {
    // asset loading go here
    var asset = Asset{
        .asset_id = asset_id,
        .subscribers = 1,
    };

    // check if stack reveals out-of-use assets to overwrite before adding mem
    if (free_size > 0) {
        free_size -= 1;
        // any relevant unloading of old asset go here
        assets.items[free_stack[free_size]] = asset;
        return free_stack[free_size];
    }

    // else append asset to end of collection, resizing if necessary
    assets.append(asset) catch |err| {
        std.debug.print("assets append error: {!}\n", .{err});
        return 0; //0 is default fallback
    };

    // give back the address
    return assets.items.len - 1;
}
