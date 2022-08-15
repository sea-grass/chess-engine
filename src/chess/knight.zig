const Moves = @import("moves.zig");
const BB = @import("bitboards.zig");

fn northNorthEast(bb: u64) u64 {
    return (bb << 15) & ~BB.a_file_bitboard;
}

fn eastEastNorth(bb: u64) u64 {
    return (bb << 6) & ~ (BB.a_file_bitboard | BB.b_file_bitboard);
}

fn eastEastSouth(bb: u64) u64 {
    return (bb >> 10) & ~ (BB.a_file_bitboard | BB.b_file_bitboard);
}

fn southSouthEast(bb: u64) u64 {
    return (bb >> 17) & ~BB.a_file_bitboard;
}

fn northNorthWest(bb: u64) u64 {
    return (bb << 17) & ~BB.h_file_bitboard;
}

fn northWestWest(bb: u64) u64 {
    return (bb << 10) & ~(BB.g_file_bitboard | BB.h_file_bitboard);
}

fn southWestWest(bb: u64) u64 {
    return (bb >> 6) & ~(BB.g_file_bitboard | BB.h_file_bitboard);
}

fn southSouthWest(bb: u64) u64 {
    return (bb >> 15) & ~BB.h_file_bitboard;
}

pub fn moves(knight_bb: u64) u64 {
    return @reduce(.Or, @Vector(8, u64){
        northNorthEast(knight_bb),
        eastEastNorth(knight_bb),
        eastEastSouth(knight_bb),
        southSouthEast(knight_bb),
        northNorthWest(knight_bb),
        northWestWest(knight_bb),
        southWestWest(knight_bb),
        southSouthWest(knight_bb),
    });
}
