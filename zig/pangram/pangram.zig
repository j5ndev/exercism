const ascii = @import("std").ascii;

pub fn isPangram(str: []const u8) bool {
    var letters = [_]u1{0} ** 26;
    for (str) |l| {
        if (!ascii.isAlphabetic(l)) continue;
        letters[ascii.toUpper(l) - 'A'] = 1;
    }
    for (letters) |v| if (v == 0) return false;
    return true;
}
