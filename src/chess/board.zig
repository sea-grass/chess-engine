var black_king_bitboard: u64 = 0;
var black_queen_bitboard: u64 = 0;
var black_rook_bitboard: u64 = 0;
var black_knight_bitboard: u64 = 0;
var black_bishop_bitboard: u64 = 0;
var black_pawn_bitboard: u64 = 0;
var white_king_bitboard: u64 = 0;
var white_queen_bitboard: u64 = 0;
var white_rook_bitboard: u64 = 0;
var white_knight_bitboard: u64 = 0;
var white_bishop_bitboard: u64 = 0;
var white_pawn_bitboard: u64 = 0;

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