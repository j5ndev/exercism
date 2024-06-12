const azScores = [_]u32 {
    1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10,
};

const lScores = [_]u32 {0} ** 65 
    ++ azScores
    ++ [_]u32 {0} ** 6
    ++ azScores
    ++ [_]u32{0} ** 134;

pub fn score(s: []const u8) u32 {
    var sum: u32 = 0;
    for (s) |l| sum += lScores[l];
    return sum;
}

