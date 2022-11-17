const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const ComptimeStringMap = std.ComptimeStringMap;
const commands = @import("commands.zig").commands;

pub fn main() anyerror!void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var args_it = try std.process.argsWithAllocator(allocator);
    defer args_it.deinit();

    // skip the executable name
    _ = args_it.skip();

    // command name must be the first argument
    const name = if (args_it.next()) |arg| arg else undefined;

    if (commands.get(name)) |command| {
        var command_args = ArrayList([]const u8).init(allocator);
        defer command_args.deinit();
        while (args_it.next()) |arg| {
            try command_args.append(arg);
        }
        try command(allocator, command_args.items);
    } else {
        if (commands.get("help")) |help| {
            try help(allocator, undefined);
        }
    }
}
