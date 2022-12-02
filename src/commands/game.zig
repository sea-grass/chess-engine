const std = @import("std");
const Allocator = std.mem.Allocator;
const Game = @import("../chess/game.zig").Game;
const Move = @import("../chess/game.zig").Move;

pub fn run(_: Allocator, _: [][]const u8) !void {
    var buffer: [64:0]u8 = undefined;
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    var game = Game.init(std.heap.page_allocator);
    defer game.deinit();

    try game.board.printBoard(stdout);
    try stdout.print("Turn {d}\n", .{ game.turn });
    try stdout.print("Num moves {d}\n", .{game.moves.items.len});

    var move = Move{};
    
    {
        try stdout.print("from: ", .{});
        var line = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')).?;
        if (line.len == 2) {
            move.from[0] = line[0];
            move.from[1] = line[1];
        }
    }

    {
        try stdout.print("to: ", .{});
        var line = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')).?;
        if (line.len == 2) {
            move.to[0] = line[0];
            move.to[1] = line[1];
        }
    }

    try game.move(move);

    try game.board.printBoard(stdout);
    try stdout.print("Turn {d}\n", .{ game.turn });
    try stdout.print("Num moves {d}\n", .{game.moves.items.len});
}