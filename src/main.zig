const std = @import("std");
const stdout = std.io.getStdOut().writer();

const Side = enum(u1) {
  white,
  black
};

const Type = enum(u3) {
  empty,
  pawn,
  bishop,
  knight,
  rook,
  queen,
  king
};

const Piece = struct {
  side: Side,
  type: Type,
};

const empty: Piece = .{ .side = .black, .type = .empty };

const Board = struct {
  piece_placement: [64]Piece,
  side_to_move: Side,
  castling_rights: u8,
  en_passant_square: u8,
  reversible_moves: u8,

  pub fn init() @This() {
    return .{
      .piece_placement = initPiecePlacement(),
      .side_to_move = .white,
      .castling_rights = 1,
      .en_passant_square = 1,
      .reversible_moves = 1,
    };
  }

  pub fn deinit(_: @This()) void {}

  fn initPiecePlacement() [64]Piece {
    return .{
      .{ .side = .black, .type = .rook }, .{ .side = .black, .type = .knight }, .{ .side = .black, .type = .bishop }, .{ .side = .black, .type = .queen }, .{ .side = .black, .type = .king }, .{ .side = .black, .type = .bishop }, .{ .side = .black, .type = .knight }, .{ .side = .black, .type = .rook }, 
      .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, .{ .side = .black, .type = .pawn }, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      empty, empty, empty, empty, empty, empty, empty, empty, 
      .{ .side = .white, .type = .rook }, .{ .side = .white, .type = .knight }, .{ .side = .white, .type = .bishop }, .{ .side = .white, .type = .queen }, .{ .side = .white, .type = .king }, .{ .side = .white, .type = .bishop }, .{ .side = .white, .type = .knight }, .{ .side = .white, .type = .rook }, 
    };
  }
};

const Game = struct {
  pub fn printBoard(_: Game) !void {
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
    try stdout.print("........\n", .{});
  }
};

pub fn main() anyerror!void {
  const game: Game = .{};

  try game.printBoard();
}

test "can init a board" {
  _ = Board.init();
}

test "can deinit a board" {
  var board = Board.init();
  board.deinit();
}

test "can create a piece" {
  var piece: Piece = .{ .type = .knight, .side = .white };
  try std.testing.expect(piece.type == .knight);
  try std.testing.expect(piece.side == .white);
}
