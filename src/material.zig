const asc = @import("assetcollection.zig");

pub const Material = struct {
    id: u32 = 0,
    subscribers: u32 = 0,
};

fn addMaterial(material_id: u32) Material {
    return Material{ .id = material_id };
}
fn remMaterial(material: *Material) void {
    _ = material;
}

pub var materials = asc.AssetCollection(Material, addMaterial, remMaterial){};
