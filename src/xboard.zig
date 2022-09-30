const std = @import("std");
const Allocator = std.mem.Allocator;

const XBoardError = error{
    InvalidHandshake,
};

fn nextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    var line = (try reader.readUntilDelimiterOrEof(
        buffer,
        '\n',
    )) orelse return null;
    // trim windows-only carriage return character
    if (@import("builtin").os.tag == .windows) {
        return std.mem.trimRight(u8, line, "\r");
    } else {
        return line;
    }
}

pub fn run(allocator: Allocator, _: [][]const u8) !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var buffer: [100]u8 = undefined;

    const file = try std.fs.cwd().openFile("log.txt", .{ .mode = .write_only });
    defer file.close();
    _ = try file.seekFromEnd(0);
    _ = try file.writeAll("New invocation\n");

    // initial handshake

    {
        const line = (try nextLine(stdin, &buffer)).?;
        if (!std.mem.eql(u8, line, "xboard")) {
            return XBoardError.InvalidHandshake;
        }
    }

    {
        const line = (try nextLine(stdin, &buffer)).?;
        if (!std.mem.eql(u8, line, "protover 2")) {
            return XBoardError.InvalidHandshake;
        }
    }

    try file.writeAll("Completed the handshake. Broadcasting features.\n");
    // declare supported features
    {
        // todo: remember which features I sent...
        try stdout.print("feature memory=1 setboard=1\n", .{});
        try stdout.print("feature option=\"resign --check 1\"\n", .{});
        // ...and receive confirmation for each feature sent,
        // before moving on.
    }

    _ = try file.writeAll("input:\n");
    while (true) {
        const input = try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024);
        if (input) |data| {
            try file.writer().print("stdin: [{s}]\n", .{data});
        }
    }
}
