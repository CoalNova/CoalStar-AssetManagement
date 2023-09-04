const msh = @import("mesh.zig");
const asc = @import("assetcollection.zig");

pub const Setpiece = struct {
    id: u32 = 0,
    subscribers: u32 = 0,
    mesh: usize = 0,
};

fn addSetpiece(setpiece_id: u32) Setpiece {
    return Setpiece{
        .id = setpiece_id,
        .mesh = msh.meshes.fetch(setpiece_id >> 1),
    };
}

fn remSetpiece(setpiece: *Setpiece) void {
    msh.meshes.release(setpiece.id >> 1);
}

pub var setpieces = asc.AssetCollection(Setpiece, addSetpiece, remSetpiece){};
