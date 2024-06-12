const std = @import("std");

pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

pub fn classify(n: u64) Classification {
    std.debug.assert(n > 0);
    var sum: u64 = 0;
    for (1..(n/2)+1) |i| {
        if (n % i == 0) sum += i;
    }
    return switch(std.math.order(sum, n)){
        .eq => .perfect,
        .lt => .deficient,
        .gt => .abundant,
    };
}
