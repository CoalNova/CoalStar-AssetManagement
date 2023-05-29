const std = @import("std");
const ast = @import("asset.zig");

/// Example User
pub const AssetUser = struct {
    asset: ?u64 = null,
};
