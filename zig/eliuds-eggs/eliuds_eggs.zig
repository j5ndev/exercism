pub fn eggCount(number: usize) usize {
    var result: usize = 0;
    var n: usize = number;
    while (n > 0) : (n >>= 1) result += n & 1;
    return result;
}