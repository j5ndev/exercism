const std = @import("std");

pub fn eggCount(number: usize) usize {
    var result: usize = 0;
    for (0..@bitSizeOf(usize)) |i| {
        result += (number & std.math.pow(usize, 2, i)) >> @truncate(i);
    }
    return result;
}