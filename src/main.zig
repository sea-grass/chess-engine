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
const XBoard = @import("xboard.zig");

const Command = enum(u8) {
    cli,
    help,
    xboard,
};

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var args_it = try std.process.argsWithAllocator(allocator);
    defer args_it.deinit();

    var command: Command = undefined;

    // skip the executable name
    _ = args_it.skip();

    // command name is the first argument
    if (args_it.next()) |arg| {
        if (std.mem.eql(u8, "cli", arg)) {
            command = .cli;
        } else if (std.mem.eql(u8, "xboard", arg)) {
            command = .xboard;
        }
    }

    // parse arguments for command
    var command_args = std.ArrayList([]const u8).init(allocator);
    defer command_args.deinit();
    while (args_it.next()) |arg| {
        try command_args.append(arg);
    }

    switch (command) {
        .cli => try Cli.run(allocator, command_args.items),
        .xboard => try XBoard.run(allocator, command_args.items),
        else => try stdout.print("I want to run command\n", .{}),
    }

    try testing();
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
