const std = @import("std");
const stdout = std.io.getStdOut().writer();
const BB = @import("chess/bitboards.zig");
const printBitboard = @import("bitboard.zig").printBitboard;
const King = @import("chess/king.zig");
const Knight = @import("chess/knight.zig");
const Moves = @import("chess/moves.zig");
const Board = @import("chess/board.zig");
const Rook = @import("chess/rook.zig");
const Cli = @import("cli.zig");

pub fn main() anyerror!void {
  const allocator = std.testing.allocator;
  var args_it = try std.process.argsWithAllocator(allocator);
  defer args_it.deinit();

  // skip the executable name
  _ = args_it.skip();

  var ran_command = false;

  if (args_it.next(allocator)) |arg| {
    if (std.mem.eql(u8, "cli", try arg)) {
      try Cli.run();
      ran_command = true;
    }
  }

  if (!ran_command) {
    try testing();
  }

}

fn testing() !void {
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

  try stdout.print("Rook moves\n", .{});
  try printBitboard(Rook.moves(bb), stdout);
}
