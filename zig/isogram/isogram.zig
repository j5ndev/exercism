const ascii = @import("std").ascii;

pub fn isIsogram(str: []const u8) bool {
    var r = [_]u8{0} ** 256;
    var i: u8 = 0;
    for (str) |l| {
        if (!ascii.isAlphabetic(l)) continue;
        i = ascii.toUpper(l);
        if (r[i] == 1) return false;
        r[i] = 1;
    }
    return true;
}
