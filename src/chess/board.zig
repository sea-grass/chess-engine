const ComptimeStringMap = @import("std").ComptimeStringMap;
const bitSet = @import("../bitboard.zig").bitSet;

/// this is a workaround for the following code that results in a segfault for some reason:
///const search = .{ .{ self.black_king_bitboard, "K" } };
///return search[0][0];
/// when a struct field is assigned and retrieved from a nested tuple, a seg fault occurs.
/// if there's only one tuple, or if the value is just used directly, no seg fault occurs.
/// It's to do with the memory offsets in the generated assembly. todo look into this more
/// Instead of keeping a single list of tuples, symbols has fields that map to the bitboard
/// fields on the board. When the board is printed, it uses symbols as a lookup to find the
/// symbol to print.
const symbols = ComptimeStringMap([]const u8, .{
  .{"black_king_bitboard", "K"},
  .{"black_queen_bitboard", "Q"},
  .{"black_rook_bitboard", "R"},
  .{"black_knight_bitboard", "N"},
  .{"black_bishop_bitboard", "B"},
  .{"black_pawn_bitboard", "P"},
  .{"white_king_bitboard", "k"},
  .{"white_queen_bitboard", "q"},
  .{"white_rook_bitboard", "r"},
  .{"white_knight_bitboard", "n"},
  .{"white_bishop_bitboard", "b"},
  .{"white_pawn_bitboard", "p"},
});

pub const Board = struct {
  black_king_bitboard: u64 = 0b0000100000000000000000000000000000000000000000000000000000000000,
  black_queen_bitboard: u64 = 0b0001000000000000000000000000000000000000000000000000000000000000,
  black_rook_bitboard: u64 = 0b1000000100000000000000000000000000000000000000000000000000000000,
  black_knight_bitboard: u64 = 0b0100001000000000000000000000000000000000000000000000000000000000,
  black_bishop_bitboard: u64 = 0b0010010000000000000000000000000000000000000000000000000000000000,
  black_pawn_bitboard: u64 = 0b0000000011111111000000000000000000000000000000000000000000000000,
  white_king_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000001000,
  white_queen_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000010000,
  white_rook_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000010000001,
  white_knight_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000001000010,
  white_bishop_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000100100,
  white_pawn_bitboard: u64 = 0b0000000000000000000000000000000000000000000000001111111100000000,

  fn blackPieces(self: Board) u64 {
      return @reduce(.Or, @Vector(6, u64){
          self.black_king_bitboard,
          self.black_queen_bitboard,
          self.black_rook_bitboard,
          self.black_knight_bitboard,
          self.black_bishop_bitboard,
          self.black_pawn_bitboard
      });
  }

  fn whitePieces(self: Board) u64 {
      return @reduce(.Or, @Vector(6, u64){
          self.white_king_bitboard,
          self.white_queen_bitboard,
          self.white_rook_bitboard,
          self.white_knight_bitboard,
          self.white_bishop_bitboard,
          self.white_pawn_bitboard
      });
  }

  fn emptySquares(self: Board) u64 {
      return ~(self.whitePieces() | self.blackPieces());
  }

  pub fn printBoard(self: Board, writer: anytype) !void {
    const fields = .{
      "black_king_bitboard",
      "black_queen_bitboard",
      "black_rook_bitboard",
      "black_knight_bitboard",
      "black_bishop_bitboard",
      "black_pawn_bitboard",
      "white_king_bitboard",
      "white_queen_bitboard",
      "white_rook_bitboard",
      "white_knight_bitboard",
      "white_bishop_bitboard",
      "white_pawn_bitboard",
    };

    var i: u8 = 0;
    while (i < 64) : (i += 1) {
      if (i > 0 and i % 8 == 0) try writer.print("\n", .{});

      // traverse board in reverse, since the top right (a8) is the first square printed
      var idx = @truncate(u6, 64 - i - 1);

      inline for (fields) |bitboard_name| {
        if (bitSet(@field(self, bitboard_name), idx)) {
          if (symbols.get(bitboard_name)) |s| {
            try writer.print("{s}", .{s});
          } else {
            // todo unreachable
            try writer.print(" ", .{});
          }
          break;
        }
      } else {
        try writer.print(".", .{});
      }
    }

    try writer.print("\n", .{});
  }
};
