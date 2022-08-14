pub fn moves(king_bb: u64) u64 {
    const vector = @splat(4, king_bb);
    const shifts = @Vector(4, u6){ 1, 7, 8, 9 };
    const left_shifted = vector << shifts;
    const right_shifted = vector >> shifts;
    return @reduce(.Or, left_shifted) | @reduce(.Or, right_shifted);
}