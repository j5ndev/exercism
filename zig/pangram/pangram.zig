const ascii = @import("std").ascii;

pub fn isPangram(str: []const u8) bool {
    var r = [_]u8{0} ** 26;
    for (str) |l| {
        if (!ascii.isAlphabetic(l)) continue;
        r[ascii.toUpper(l) - 'A'] = 1;
    }
    for (r) |v| if (v == 0) return false;
    return true;
}
