const std = @import("std");

//put this here
var general_purpose_alligator = std.heap.GeneralPurposeAllocator(.{}){};
pub const gpa = general_purpose_alligator.allocator();

/// AssetCollection is a generic type which should be able to be widly implemented for all referenced
/// instanced assets.
///
/// T is the asset type to be used, and must contain fields for [id] and [sbscribers]
/// size is to be removed for arraylist impl
/// add and remove are the functions to add and remove assets when necessary
pub fn AssetCollection(
    comptime T: type,
    comptime add_asset: fn (asset_id: u32) T,
    comptime remove_asset: fn (asset: *T) void,
) type {
    return struct {
        const Self = @This();
        collection: std.ArrayList(T) = undefined,
        comptime add: fn (asset_id: u32) T = add_asset,
        comptime remove: fn (asset: *T) void = remove_asset,
        pub fn init(this: *Self, allocator: std.mem.Allocator) void {
            this.collection = std.ArrayList(T).init(allocator);
        }
        pub fn deinit(this: *Self) void {
            for (this.collection.items) |*asset| {
                std.log.info("Deinit removing {}", .{asset.id});
                this.remove(asset);
            }
            this.collection.deinit();
        }
        /// Returns the index of an asset, which will be used with peek() to access the data
        pub fn fetch(this: *Self, asset_id: u32) usize {
            //check if exists
            for (0..this.collection.items.len) |i|
                if (this.collection.items[i].id == asset_id) {
                    std.log.info("Item {} exists, adding", .{asset_id});
                    this.collection.items[i].subscribers += 1;
                    return i;
                };

            //else look for any unused
            for (0..this.collection.items.len) |i| {
                if (this.collection.items[i].subscribers < 1) {
                    std.log.info("Item {} doesn't exist in full collection, replacing existing", .{asset_id});
                    this.remove(&this.collection.items[i]);
                    var asset = this.add(asset_id);
                    asset.subscribers += 1;
                    this.collection.items[i] = asset;
                    return i;
                }
            }

            //place at end
            {
                std.log.info("Item {} doesn't exist, adding to the end", .{asset_id});
                var asset = this.add(asset_id);
                asset.subscribers = 1;
                this.collection.append(asset) catch |err| {
                    std.log.err("Asset collection could not be resized: {!}", .{err});
                    return 0;
                };
                return this.collection.items.len - 1;
            }
        }
        /// Releases the useage of an instance of the asset
        pub fn release(this: *Self, asset_id: u32) void {
            for (this.collection.items) |*a| {
                if (a.id == asset_id) {
                    a.subscribers -= 1;
                    std.log.info("Removing {} from collection, remaining subscribers {}", .{ a.id, a.subscribers });
                    return;
                }
            }
        }
        pub fn peek(this: *Self, index: usize) *T {
            return &this.collection.items[index];
        }
    };
}
