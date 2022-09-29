const std = @import("std");

const Command = struct {
  code: []const u8,
  name: []const u8
};

pub fn run() !void {
  const stdout = std.io.getStdOut().writer();
  const stdin = std.io.getStdIn().reader();

  const command: Command = .{ .code = "q", .name = "Quit" };

  try stdout.print("CHESS PROGRAM v0.1\n", .{});
  try stdout.print("Choose a command:\n", .{});

  try stdout.print("\t({s}): {s}\n", .{ command.code, command.name });

  var buffer: [64:0]u8 = undefined;
  var line = (try stdin.readUntilDelimiterOrEof(&buffer, '\n')).?;

  if (std.mem.eql(u8, line, command.code)) {
    try stdout.print("running {s}\n", .{ command.name });
  }
}
