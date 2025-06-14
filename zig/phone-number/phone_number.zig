const ascii = @import("std").ascii;

pub fn clean(phrase: []const u8) ?[10]u8 {
    var count: u32 = 0;
    var result: [10]u8 = .{0} ** 10;
    for (phrase) |c| {
        if (ascii.isDigit(c)) {
            if (count == 10) return null;
            if (count == 0 and c == '1') continue;
            if (count == 0 and c == '0') return null;
            if (count == 3 and (c == '0' or c == '1')) return null;
            result[count] = c;
            count += 1;
        }
    }
    if (count < 10) return null;
    return result;
}
