// Adapted from:
//   https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Binary_numeral_system_(base_2)
pub fn squareRoot(radicand: usize) usize {
    var x: usize = radicand;
    var c: usize = 0;

    // largest power of 4 in usize
    var d: usize = 1 << @bitSizeOf(usize) - 2;

    // largest power of four <= n
    while (d > radicand) d >>= 2;

    while (d != 0) {
        if (x >= c + d) {
            x -= c + d;
            c = (c >> 1) + d;
        } else {
            c >>= 1;
        }
        d >>= 2;
    }
    return c;
}
