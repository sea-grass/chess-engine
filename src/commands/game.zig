const std = @import("std");
const Allocator = std.mem.Allocator;
const Game = @import("../chess/game.zig").Game;

pub fn run(_: Allocator, _: [][]const u8) !void {
    const stdout = std.io.getStdOut().writer();
    var game = Game.init(std.heap.page_allocator);
    defer game.deinit();

    try game.board.printBoard(stdout);
    try stdout.print("Turn {d}\n", .{ game.turn });
    try stdout.print("Num moves {d}\n", .{game.moves.items.len});
}