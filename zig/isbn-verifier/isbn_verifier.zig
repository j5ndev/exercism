const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var countDown: u8 = 10;
    var sum: usize = 0;
    for (s) |l| {
        if (countDown < 1) return false;
        const digit = switch (l) {
            '0'...'9' => l - '0',
            'X' => if (countDown == 1) 10 else return false,
            '-' => continue,
            else => return false,
        };
        sum += digit * countDown;
        countDown -= 1;
    }
    if (countDown != 0) return false;
    return sum % 11 == 0;
}
