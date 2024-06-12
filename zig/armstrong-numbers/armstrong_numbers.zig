const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {

    // Calculate the number of digits
    var count: u8 = 0;
    var rest: u128 = num;
    var digits = [_]u8{0}**39;
    while (rest > 0) {
        digits[count] = @intCast(rest % 10);
        rest = rest / 10;
        count += 1;
    }

    // Calculate the result
    var result: u128 = 0;
    for (0..count) |i| result += std.math.pow(u128, digits[i], count);

    return result == num;
}
