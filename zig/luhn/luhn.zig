const std = @import("std");

pub fn isValid(s: []const u8) bool {
    var sum: usize = 0;
    var count: usize = 0;
    var i: i128 = @as(i128, s.len) - 1;
    while (i >= 0): (i -= 1) {
        const d: u8 = s[@as(i128, i)];
        if (d == ' ') continue;
        if (!std.ascii.isDigit(d)) return false;
        count += 1;
        const isEven:bool = count % 2 == 0;
        const digit:usize = d - '0';
        if (isEven) {
            var value: usize = digit * 2;
            if (value > 9) value -= 9;
            sum += value;
        } else {
            sum += digit;
        }
    }
    if (count < 2) return false;
    return sum % 10 == 0 ;
}
