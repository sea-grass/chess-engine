const std = @import("std");
const CastlingRights = @import("fen/castling_rights.zig").CastlingRights;
const EnPassant = @import("fen/en_passant.zig").EnPassant;

const Colour = enum {
    White,
    Black,
};

const ParseError = error{
    InvalidFEN,
    NotEnoughRows,
    TooManyRows,
};

const FEN = struct {
    board: []const u8,
    active_colour: Colour,
    castling: CastlingRights,
    en_passant: EnPassant,
    halfmove_clock: []const u8,
    fullmove_number: []const u8,

    pub fn parse(fen_str: []const u8) !FEN {
        var it = std.mem.tokenize(u8, fen_str, " ");

        var board = it.next() orelse return ParseError.InvalidFEN;
        {
            var i: usize = 0;
            var board_it = std.mem.tokenize(u8, board, "/");
            while (board_it.next()) |_| {
                if (i >= 8) return ParseError.TooManyRows;
                //std.debug.print("row: {s}\n", .{row});
                i += 1;
            }
            if (i < 8) {
                return ParseError.NotEnoughRows;
            }
        }
        var active_colour: Colour = undefined;
        {
            var val = it.next() orelse "";
            if (val.len == 1) {
                if (val[0] == 'w') {
                    active_colour = .White;
                } else {
                    active_colour = .Black;
                }
            }
        }

        const fen = .{
            .board = board,
            .active_colour = active_colour,
            .castling = try CastlingRights.parse(it.next() orelse return ParseError.InvalidFEN),
            .en_passant = try EnPassant.parse(it.next() orelse return ParseError.InvalidFEN),
            .halfmove_clock = it.next() orelse return ParseError.InvalidFEN,
            .fullmove_number = it.next() orelse return ParseError.InvalidFEN,
        };

        // if there are additional symbols, the input is considered invalid.
        if (it.next()) |_| return ParseError.InvalidFEN;

        return fen;
    }

    test "import FEN" {
        const fen_str = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";

        const fen = try FEN.parse(fen_str);
        std.debug.print("\n{s}\n", .{fen.board});
        std.debug.print("active: {}\n", .{fen.active_colour});
        std.debug.print("castling rights: {}\n", .{fen.castling});
        std.debug.print("en passant: {}\n", .{fen.en_passant});
        std.debug.print("halfmove clock: {s}\n", .{fen.halfmove_clock});
        std.debug.print("fullmove number: {s}\n", .{fen.fullmove_number});
    }

    test "too short FEN" {
        const invalid_fen = "";
        const result = FEN.parse(invalid_fen);
        try std.testing.expectError(ParseError.InvalidFEN, result);
    }

    test "too long FEN" {
        const invalid_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" ++ " some extra stuff";
        const result = FEN.parse(invalid_fen);
        try std.testing.expectError(ParseError.InvalidFEN, result);
    }

    test "export FEN" {}
};

test {
    _ = FEN;
    _ = CastlingRights;
    _ = EnPassant;
}
