const std = @import("std");

const ParseError = error{
    TooShort,
};

pub const EnPassant = struct {
    target: ?[]const u8,
    pub fn parse(en_passant_str: []const u8) ParseError!EnPassant {
        if (en_passant_str.len == 0) return ParseError.TooShort;
        if (en_passant_str.len == 1 and en_passant_str[0] == '-') return .{
            .target = null,
        };
        // todo: ensure valid board position
        return .{
            .target = en_passant_str,
        };
    }

    test "no en passant square" {
        const result = try EnPassant.parse("-");
        try std.testing.expect(result.target == null);
    }

    test "has en passant square" {
        const result = try EnPassant.parse("a8");
        try std.testing.expect(
            std.mem.eql(u8, result.target.?, "a8"),
        );
    }
};
