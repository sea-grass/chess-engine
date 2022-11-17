const std = @import("std");
const Allocator = std.mem.Allocator;
const BB = @import("../chess/bitboards.zig");
const printBitboard = @import("../bitboard.zig").printBitboard;
const King = @import("../chess/king.zig");
const Knight = @import("../chess/knight.zig");
const Moves = @import("../chess/moves.zig");
const Board = @import("../chess/board.zig").Board;
const Rook = @import("../chess/rook.zig");

const Command = struct { code: []const u8, name: []const u8 };

pub fn run(_: Allocator, _: [][]const u8) !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    const command: Command = .{ .code = "q", .name = "Quit" };

    try stdout.print("CHESS PROGRAM v0.1\n", .{});
    try stdout.print("Choose a command:\n", .{});

    try stdout.print("\t({s}): {s}\n", .{ command.code, command.name });

    var buffer: [64:0]u8 = undefined;
    var line = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')).?;

    if (std.mem.eql(u8, line, command.code)) {
        try stdout.print("running {s}\n", .{command.name});
    }

    try testing();
}

fn testing() !void {
    const bb = 1 << 13;
    const stdout = std.io.getStdOut().writer();
    var board = Board{};

    try stdout.print("origin\n", .{});
    try printBitboard(bb, stdout);

    // const king_moves = King.moves(bb);
    // try stdout.print("king moves\n", .{});
    // try printBitboard(king_moves, stdout);

    try stdout.print("knight moves\n", .{});
    try printBitboard(Knight.moves(bb), stdout);

    try stdout.print("Chess board\n", .{});
    try board.printBoard(stdout);

    try stdout.print("Rook moves\n", .{});
    try printBitboard(Rook.moves(bb), stdout);
}
