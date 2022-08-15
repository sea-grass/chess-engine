const Moves = @import("moves.zig");

pub fn moves(king_bb: u64) u64 {
    return @reduce(.Or, @Vector(8, u64){
        Moves.eastOne(king_bb),
        Moves.northEastOne(king_bb),
        Moves.northOne(king_bb),
        Moves.northWestOne(king_bb),
        Moves.southEastOne(king_bb),
        Moves.southOne(king_bb),
        Moves.southWestOne(king_bb),
        Moves.westOne(king_bb)
    });
}