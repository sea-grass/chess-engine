const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const Board = @import("board.zig").Board;
const Move = struct {};

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
};
