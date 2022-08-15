const Moves = @import("moves.zig");

const Direction = enum {
    north,
    south
};

pub fn moves(pawn_bb: u64, dir: Direction) u64 {
    return switch(dir) {
        .north => Moves.northOne(pawn_bb),
        .south => Moves.southOne(pawn_bb)
    };
}