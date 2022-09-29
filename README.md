# chess-engine

Chess engine written in Zig

> **Note**
>
> This repository contains work-in-progress. Any code, documentation, etc. should be considered as such and not taken at face value.

## Implementation

### Board representation

- Keeps track of the board
- Knows the rules of the game

I'm going to try to go with a bitboard-based board representation. It seems intuitive when you consider a 64-tile board turns into a 64-bit representation, which can be operated on with a single instruction on a 64-bit processor.

### Bitboard operations

When determining moves for a piece, let's say the blackside king, we'll need to do the following:

- From the king's position, determine all possible positions the king could move
- Prune positions that already contain a blackside piece, since the king cannot move into a space that is already occupied
- Prune positions that are under threat from a whiteside piece, since a chess player cannot make a move that would threaten their king

#### All possible positions

##### Bitshifting

To create a bitboard of all of the king's possible moves based on its current position, we can take the current position bitboard and use a bitshift.

Since the king can move in all (eight) directions, we need to bitshift the bitboard 8 times and then `and` the result.

I'm thinking it'll look something like this:

```zig
fn moves(king_bb: u64) u64 {
    const vector = @splat(4, king_bb);
    const shifts = @Vector(4, u6){ 1, 7, 8, 9 };
    const left_shifted = vector << shifts;
    const right_shifted = vector >> shifts;
    return @reduce(.Or, left_shifted) | @reduce(.Or, right_shifted);
}
```

In the above code sample, we take an input bitboard where each 1-bit represents a king at that location. Then, we use vector operations to perform bitwise operations on copies of the bitboard in bulk. Finally, we take the results of these bitwise operations and `OR` them together to produce a bitboard with all possible positions a king could end up in.

This approach would work well for half of the piece types: pawn, king, knight. For pieces with greater movement potential (queen, rook, bishop), I'd need to consider another solution.

Another point to consider is that this doesn't disqualify wrap-around moves. Since the bitboard represents the 2-dimensional board in a single set, it's possible during a bitshift for the positions to wrap around, while this doesn't amount to a legal move in chess. What would be a good approach to tackle this problem?

#### Other

I've seen documents on using "rays" to describe valid movement of a piece. Let's consider the queen, which can move in all directions as well. However, the queen can travel any number of spaces.

> Aside: When determining whether a move is "valid" we'd need to additionally ensure there are no same-colour pieces in the way. If there are pieces from the opponent's side, the queen may travel to that piece and capture it. Additionally, the queen (along with any other piece) may not make a move that would render the king vulnerable. This method of move pruning may happen after all possible moves are generated (or before, if it moves wasteful. We'll see).

An approach that might be possible would be to take a bitboard of the queen's "maximal" number of movement, where it's somewhere in the center. Then, take the queen bitboard, find each 1-bit index, bitshift the "master" moves bitboard to center in on each position, and `OR` those together.

However, these seems pretty complicated. A simpler approach might see repeated bitshifts until a bitshift is ineffective (the queen would travel out of bounds or something). I need to do more research into the "rays" approach to get a good idea of this piece movement.

### Search

### Evaluation

### GUI

- No GUI
- Supports XBoard instead.

#### XBoard

### Supporting Xboard (aka CECP or Winboard) protocol

ChessX will launch the binary and send the following over stdin:

```
xboard
protover 2
```

That much I was able to figure out. But I'm guessing it expects a response after it sends me these commands. I tried the chessprogramming wiki, but I haven't been able to really find a spec for the protocol. I may have to start searching up keywords and look at other engines for insight. The source for [belofte](https://sourceforge.net/p/belofte) (written in C++) seems promising.
