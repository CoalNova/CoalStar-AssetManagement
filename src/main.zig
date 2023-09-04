const std = @import("std");
const asc = @import("assetcollection.zig");
const stp = @import("setpiece.zig");
const msh = @import("mesh.zig");
const mat = @import("material.zig");

pub fn main() void {
    mat.materials.init(asc.gpa);
    defer mat.materials.deinit();
    msh.meshes.init(asc.gpa);
    defer msh.meshes.deinit();
    stp.setpieces.init(asc.gpa);
    defer stp.setpieces.deinit();

    //for this demonstration, the id's are generational metadata, and are categorized through bitshift
    //in execution, id should be consistant and derived at asset-level
    const tree_type_1_id = 4;
    const tree_type_2_id = 5;
    const bush_type_1_id = 6;
    const rock_type_1_id = 8;

    var tree_1_index = stp.setpieces.fetch(tree_type_1_id);
    var tree_2_index = stp.setpieces.fetch(tree_type_2_id);
    var bush_1_index = stp.setpieces.fetch(bush_type_1_id);
    var rock_1_index = stp.setpieces.fetch(rock_type_1_id);

    //check info
    std.debug.print(
        "setpiece tree1, id:{} at {} is used {} times. \n\tMesh is {} times, material {} times\n",
        .{
            stp.setpieces.peek(tree_1_index).id,
            tree_1_index,
            stp.setpieces.peek(tree_1_index).subscribers,
            msh.meshes.peek(stp.setpieces.peek(tree_1_index).mesh).subscribers,
            mat.materials.peek(msh.meshes.peek(stp.setpieces.peek(tree_1_index).mesh).material).subscribers,
        },
    );
    std.debug.print(
        "setpiece tree2, id:{} at {} is used {} times.\n\tMesh is {} times, material {} times\n",
        .{
            stp.setpieces.peek(tree_2_index).id,
            tree_2_index,
            stp.setpieces.peek(tree_2_index).subscribers,
            msh.meshes.peek(stp.setpieces.peek(tree_2_index).mesh).subscribers,
            mat.materials.peek(msh.meshes.peek(stp.setpieces.peek(tree_2_index).mesh).material).subscribers,
        },
    );
    std.debug.print(
        "setpiece bush1, id:{} at {} is used {} times.\n\tMesh is {} times, material {} times\n",
        .{
            stp.setpieces.peek(bush_1_index).id,
            bush_1_index,
            stp.setpieces.peek(bush_1_index).subscribers,
            msh.meshes.peek(stp.setpieces.peek(bush_1_index).mesh).subscribers,
            mat.materials.peek(msh.meshes.peek(stp.setpieces.peek(bush_1_index).mesh).material).subscribers,
        },
    );
    std.debug.print(
        "setpiece rock1, id:{} at {} is used {} times.\n\tMesh is {} times, material {} times\n",
        .{
            stp.setpieces.peek(rock_1_index).id,
            rock_1_index,
            stp.setpieces.peek(rock_1_index).subscribers,
            msh.meshes.peek(stp.setpieces.peek(rock_1_index).mesh).subscribers,
            mat.materials.peek(msh.meshes.peek(stp.setpieces.peek(rock_1_index).mesh).material).subscribers,
        },
    );

    //let go
    stp.setpieces.release(0);
    stp.setpieces.release(0);
    stp.setpieces.release(1);
}
