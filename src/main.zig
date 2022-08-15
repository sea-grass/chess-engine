const std = @import("std");
const stdout = std.io.getStdOut().writer();
const BB = @import("chess/bitboards.zig");
const printBitboard = @import("bitboard.zig").printBitboard;
const King = @import("chess/king.zig");
const Knight = @import("chess/knight.zig");
const Moves = @import("chess/moves.zig");
const Board = @import("chess/board.zig");

pub fn main() anyerror!void {
  const bb = 1 << 13;

  try stdout.print("origin\n", .{});
  try printBitboard(bb, stdout);

  // const king_moves = King.moves(bb);
  // try stdout.print("king moves\n", .{});
  // try printBitboard(king_moves, stdout);

  try stdout.print("knight moves\n", .{});
  try printBitboard(Knight.moves(bb), stdout);

  try stdout.print("Chess board\n", .{});
  try Board.printBoard(stdout);
}
