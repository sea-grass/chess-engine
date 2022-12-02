const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const Board = @import("board.zig").Board;

pub const Move = struct {
    piece: Piece = undefined,
    from: [2:0]u8 = undefined,
    to: [2:0]u8 = undefined,
};

const PieceType = enum {
    Pawn,
    Knight,
    Bishop,
    Rook,
    Queen,
    King,
};

const Side = enum {
    Black,
    White,
};

const Piece = struct {
    side: Side,
    piece: PieceType,
};

const p = Piece{.side = .Black, .piece = .King};

pub const Game = struct{
    board: Board,
    turn: u32,
    moves: ArrayList(Move),
    allocator: Allocator,

    pub fn init(allocator: Allocator) Game {
        return Game{
            .allocator = allocator,
            .turn = 1,
            .board = Board{},
            .moves= ArrayList(Move).init(allocator),
        };
    }

    pub fn deinit(self: *Game) void {
        self.moves.deinit();
    }

    pub fn move(self: *Game, m: Move) !void {
        const m2 = Move { .piece = Piece{.side=.Black,.piece=.Pawn}, .from=m.from, .to=m.to};
        try self.moves.append(m2);
    }
};
