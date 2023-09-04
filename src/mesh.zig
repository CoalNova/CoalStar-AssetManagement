const mat = @import("material.zig");
const asc = @import("assetcollection.zig");

pub const Mesh = struct {
    id: u32 = 0,
    subscribers: u32 = 0,
    material: usize = undefined,
};

fn addMesh(mesh_id: u32) Mesh {
    return Mesh{
        .id = mesh_id,
        .material = mat.materials.fetch(mesh_id >> 1),
    };
}
fn remMesh(mesh: *Mesh) void {
    mat.materials.release(mesh.id >> 1);
}

pub var meshes = asc.AssetCollection(Mesh, addMesh, remMesh){};
