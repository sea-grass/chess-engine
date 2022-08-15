pub const empty_bitboard: u64 = 0;
pub const universe_bitboard: u64 = ~0;

pub const a_file_bitboard: u64 = 0b1000000010000000100000001000000010000000100000001000000010000000;
pub const b_file_bitboard: u64 = 0b0100000001000000010000000100000001000000010000000100000001000000;
pub const g_file_bitboard: u64 = 0b0000001000000010000000100000001000000010000000100000001000000010;
pub const h_file_bitboard: u64 = 0b0000000100000001000000010000000100000001000000010000000100000001;

pub const rank_1_bitboard: u64 = 0b0000000000000000000000000000000000000000000000000000000011111111;
pub const rank_8_bitboard: u64 = 0b1111111100000000000000000000000000000000000000000000000000000000;