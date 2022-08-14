const std = @import("std");

const Bitboard = u64;

pub const king_bitboard: Bitboard = 0b0000000000000000000000000000000000000000000000000000000000001000;

pub fn printBitboard(bitboard: Bitboard, writer: anytype) !void {
    var bits: [64]u8 = .{0} ** 64;
    var curr: u64 = bitboard;

    var count: usize = 0;
    while (count < 64) : (count += 1) {
        const i: usize = 64 - count - 1;
        bits[i] = if (curr % 2 == 0) '0' else '1';
        curr >>= 1;
    }

    count = 0;
    for (bits) |character| {
        try writer.print("{c}", .{character});
        count += 1;
        if (count == 8) {
            try writer.print("\n", .{});
            count = 0;
        }
    }
}