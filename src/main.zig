const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const ComptimeStringMap = std.ComptimeStringMap;
const Cli = @import("cli.zig");
const XBoard = @import("xboard.zig");

const command_map = ComptimeStringMap(fn (Allocator, [][]const u8) anyerror!void, .{
    .{ "cli", Cli.run },
    .{ "xboard", XBoard.run },
});

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var args_it = try std.process.argsWithAllocator(allocator);
    defer args_it.deinit();

    // skip the executable name
    _ = args_it.skip();

    // parse the command name
    const name = if (args_it.next()) |arg| arg else undefined;

    if (command_map.get(name)) |command| {
        // parse arguments for command
        var command_args = ArrayList([]const u8).init(allocator);
        defer command_args.deinit();
        while (args_it.next()) |arg| {
            try command_args.append(arg);
        }
        try command(allocator, command_args.items);
    }
}
