pub const ChessboardError = error{
    IndexOutOfBounds,
};

pub fn board() [64]usize {
    var b = [_]usize {0}**64;
    b[0] = 1;
    for (1..64) |i| b[i] = 2 * b[i-1];
    return b;
}

const squares = board();

pub fn square(index: usize) ChessboardError!u64 {
    if (index > squares.len or index < 1 ) return ChessboardError.IndexOutOfBounds;
    return squares[index-1];
}

pub fn total() u64 {
    var sum: u64 = 0;
    for (squares) |v| sum += v;
    return sum;
}
