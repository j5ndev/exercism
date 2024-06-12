pub const QueenError = error {
    InitializationFailure,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row < 0 or row > 7 or col < 0 or col > 7) return QueenError.InitializationFailure;
        return Queen {
            .row = row,
            .col = col,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        const sameRow: bool = self.row == other.row;
        const sameCol: bool = self.col == other.col;
        if (sameRow and sameCol) return QueenError.InitializationFailure;
        if (sameRow or sameCol) return true;
        return @abs(self.row - other.row) == @abs(self.col - other.col);
    }
};
