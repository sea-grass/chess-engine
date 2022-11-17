const std = @import("std");
const Allocator = std.mem.Allocator;
const ComptimeStringMap = std.ComptimeStringMap;
const Cli = @import("commands/cli.zig");
const XBoard = @import("commands/xboard.zig");
const Game = @import("commands/game.zig");

const F = fn (Allocator, [][]const u8) anyerror!void;

pub const commands = ComptimeStringMap(fn (Allocator, [][]const u8) anyerror!void, .{
    .{ "cli", Cli.run },
    .{ "xboard", XBoard.run },
    .{ "help", help },
    .{ "game", Game.run },
});

fn help(_: Allocator, _: [][]const u8) !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("help text\n", .{});
}
