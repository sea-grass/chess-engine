const Moves = @import("moves.zig");
const BB = @import("bitboards.zig");

fn northThenEast(bb: u64) u64 {
    return (bb << 15) & ~BB.a_file_bitboard;
}

fn eastThenNorth(bb: u64) u64 {
    return (bb << 6) & ~ (BB.a_file_bitboard | BB.b_file_bitboard);
}

fn eastThenSouth(bb: u64) u64 {
    return (bb >> 10) & ~ (BB.a_file_bitboard | BB.b_file_bitboard);
}

fn southThenEast(bb: u64) u64 {
    return (bb >> 17) & ~BB.a_file_bitboard;
}

fn northThenWest(bb: u64) u64 {
    return (bb << 17) & ~BB.h_file_bitboard;
}

fn westThenNorth(bb: u64) u64 {
    return (bb << 10) & ~(BB.g_file_bitboard | BB.h_file_bitboard);
}

fn westThenSouth(bb: u64) u64 {
    return (bb >> 6) & ~(BB.g_file_bitboard | BB.h_file_bitboard);
}

fn southThenWest(bb: u64) u64 {
    return (bb >> 15) & ~BB.h_file_bitboard;
}

pub fn moves(knight_bb: u64) u64 {
    return @reduce(.Or, @Vector(8, u64){
        northThenEast(knight_bb),
        eastThenNorth(knight_bb),
        eastThenSouth(knight_bb),
        southThenEast(knight_bb),
        northThenWest(knight_bb),
        westThenNorth(knight_bb),
        westThenSouth(knight_bb),
        southThenWest(knight_bb),
    });
}