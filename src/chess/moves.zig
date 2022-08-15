const std = @import("std");
const BB = @import("bitboards.zig");

pub fn southOne(bb: u64) u64 {
    return bb >> 8;
}

pub fn northOne(bb: u64) u64 {
    return bb << 8;
}

pub fn eastOne(bb: u64) u64 {
    return (bb >> 1) & ~BB.a_file_bitboard;
}

pub fn northEastOne(bb: u64) u64 {
    return (bb << 7) & ~BB.a_file_bitboard;
}

pub fn southEastOne(bb: u64) u64 {
    return (bb >> 9) & ~BB.a_file_bitboard;
}

pub fn westOne(bb: u64) u64 {
    return (bb << 1) & ~BB.h_file_bitboard;
}

pub fn northWestOne(bb: u64) u64 {
    return (bb << 9) & ~BB.h_file_bitboard;
}

pub fn southWestOne(bb: u64) u64 {
    return (bb >> 7) & ~BB.h_file_bitboard;
}

test "southOne" {
    // Any moves from the first rank should result in an empty bitboard
    const result = southOne(BB.rank_1_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "northOne" {
    // Any moves from the first rank should result in an empty bitboard
    const result = northOne(BB.rank_8_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "eastOne" {
    // Any moves from the H file should result in an empty bitboard
    const result = eastOne(BB.h_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "northEastOne" {
    // Any moves from the H file should result in an empty bitboard
    const result = northEastOne(BB.h_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "southEastOne" {
    // Any moves from the H file should result in an empty bitboard
    const result = southEastOne(BB.h_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "westOne" {
    // Any moves from the A file should result in an empty bitboard
    const result = westOne(BB.a_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "northWestOne" {
    // Any moves from the A file should result in an empty bitboard
    const result = northWestOne(BB.a_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}

test "southWestOne" {
    // Any moves from the A file should result in an empty bitboard
    const result = southWestOne(BB.a_file_bitboard);

    try std.testing.expect(result == BB.empty_bitboard);
}