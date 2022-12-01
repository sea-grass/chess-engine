const std = @import("std");

const Side = struct {
    king: bool,
    queen: bool,
};

const ParseError = error{
    TooShort,
    DuplicateSymbol,
    UnknownSymbol,
};

pub const CastlingRights = struct {
    white: Side,
    black: Side,
    pub fn parse(castling_str: []const u8) ParseError!CastlingRights {
        if (castling_str.len == 0) return ParseError.TooShort;
        if (castling_str.len == 1 and castling_str[0] == '-') return .{
            .white = .{ .king = false, .queen = false },
            .black = .{ .king = false, .queen = false },
        };

        var seen = struct {
            black_king: bool = false,
            black_queen: bool = false,
            white_king: bool = false,
            white_queen: bool = false,
        }{};

        var i: usize = 0;
        while (i < castling_str.len) : (i += 1) {
            switch (castling_str[i]) {
                'K' => {
                    if (seen.white_king) return ParseError.DuplicateSymbol;
                    seen.white_king = true;
                },
                'Q' => {
                    if (seen.white_queen) return ParseError.DuplicateSymbol;
                    seen.white_queen = true;
                },
                'k' => {
                    if (seen.black_king) return ParseError.DuplicateSymbol;
                    seen.black_king = true;
                },
                'q' => {
                    if (seen.black_queen) return ParseError.DuplicateSymbol;
                    seen.black_queen = true;
                },
                else => {
                    return ParseError.UnknownSymbol;
                },
            }
        }

        return .{
            .white = .{
                .king = seen.white_king,
                .queen = seen.white_queen,
            },
            .black = .{
                .king = seen.black_king,
                .queen = seen.black_queen,
            },
        };
    }

    test "parse none" {
        const result = try CastlingRights.parse("-");
        try std.testing.expect(result.white.king == false and result.white.queen == false);
        try std.testing.expect(result.black.king == false and result.black.queen == false);
    }

    test "parse white" {
        const result = try CastlingRights.parse("KQ");
        try std.testing.expect(result.white.king == true and result.white.queen == true);
        try std.testing.expect(result.black.king == false and result.black.queen == false);
    }
};
