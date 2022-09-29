const bitSet = @import("../bitboard.zig").bitSet;
const Moves = @import("moves.zig");

pub fn moves(rook_bb: u64) u64 {
    // TODO: implement
    // find all 1 bit indices
    // for each 1 bit index, blit a rank full of 1s
    // for each 1 bit index, blit a file full of 1s
    // finally, subtract the original positions
    // but...what if two rooks are in the same rank/file?
    // I only need to subtract original positions, not moves too

    return rook_bb;
}

