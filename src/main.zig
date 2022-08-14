const std = @import("std");
const stdout = std.io.getStdOut().writer();
const BB = @import("bitboard.zig");
const King = @import("chess/king.zig");



pub fn main() anyerror!void {
  const bb = 1 << 32;
  const king_moves = King.moves(bb);

  try BB.printBitboard(king_moves, stdout);
}