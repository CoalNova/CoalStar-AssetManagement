const std = @import("std");
const ast = @import("asset.zig");
const usr = @import("assetuser.zig");

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    //init asset structure, because checking every call is not lazy enough
    ast.init(allocator);
    defer ast.deinit();
    //generate assetuser
    var a_user: usr.AssetUser = .{};
    var b_user: usr.AssetUser = .{};
    //simulate loading of assets
    a_user.asset = ast.fetchAsset(12);
    b_user.asset = ast.fetchAsset(8);

    //check info
    std.debug.print("Asset of user_a : {d} is \n\t{}\n", .{ a_user.asset.?, ast.peekAsset(a_user.asset.?) });
    std.debug.print("Asset of user_b : {d} is \n\t{}\n", .{ b_user.asset.?, ast.peekAsset(b_user.asset.?) });

    //let go
    ast.releaseAsset(a_user.asset.?);
    ast.releaseAsset(b_user.asset.?);
}
