var black_king_bitboard: u64 = 0b0000100000000000000000000000000000000000000000000000000000000000;
var black_queen_bitboard: u64 = 0b0001000000000000000000000000000000000000000000000000000000000000;
var black_rook_bitboard: u64 = 0b1000000100000000000000000000000000000000000000000000000000000000;
var black_knight_bitboard: u64 = 0b0100001000000000000000000000000000000000000000000000000000000000;
var black_bishop_bitboard: u64 = 0b0010010000000000000000000000000000000000000000000000000000000000;
var black_pawn_bitboard: u64 = 0b0000000011111111000000000000000000000000000000000000000000000000;
var white_king_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000001000;
var white_queen_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000010000;
var white_rook_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000010000001;
var white_knight_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000001000010;
var white_bishop_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000000100100;
var white_pawn_bitboard: u64 = 0b0000000000000000000000000000000000000000000000001111111100000000;

fn blackPieces() u64 {
    return @reduce(.Or, @Vector(6, u64){
        black_king_bitboard,
        black_queen_bitboard,
        black_rook_bitboard,
        black_knight_bitboard,
        black_bishop_bitboard,
        black_pawn_bitboard
    });
}

fn whitePieces() u64 {
    return @reduce(.Or, @Vector(6, u64){
        white_king_bitboard,
        white_queen_bitboard,
        white_rook_bitboard,
        white_knight_bitboard,
        white_bishop_bitboard,
        white_pawn_bitboard
    });
}

fn emptySquares() u64 {
    return ~(whitePieces() | blackPieces());
}

fn bitSet(bb: u64, idx: u6) bool {
  return ((bb >> idx) % 2) != 0;
}

pub fn printBoard(writer: anytype) !void {
  var i: u8 = 0;
  while (i < 64) : (i += 1) {
    if (i > 0 and i % 8 == 0) try writer.print("\n", .{});

    // traverse board in reverse, since the top right (a8) is the first square printed
    var idx = @truncate(u6, 64 - i - 1);

    if (bitSet(black_king_bitboard, idx)) {
      try writer.print("K", .{});
    } else if (bitSet(black_queen_bitboard, idx)) {
      try writer.print("Q", .{});
    } else if (bitSet(black_bishop_bitboard, idx)) {
      try writer.print("B", .{});
    } else if (bitSet(black_knight_bitboard, idx)) {
      try writer.print("N", .{});
    } else if (bitSet(black_rook_bitboard, idx)) {
      try writer.print("R", .{});
    } else if (bitSet(black_pawn_bitboard, idx)) {
      try writer.print("P", .{});
    } else if (bitSet(white_king_bitboard, idx)) {
      try writer.print("k", .{});
    } else if (bitSet(white_queen_bitboard, idx)) {
      try writer.print("q", .{});
    } else if (bitSet(white_bishop_bitboard, idx)) {
      try writer.print("b", .{});
    } else if (bitSet(white_knight_bitboard, idx)) {
      try writer.print("n", .{});
    } else if (bitSet(white_rook_bitboard, idx)) {
      try writer.print("r", .{});
    } else if (bitSet(white_pawn_bitboard, idx)) {
      try writer.print("p", .{});
    } else {
      try writer.print(".", .{});
    }

  }
  try writer.print("\n", .{});
}
