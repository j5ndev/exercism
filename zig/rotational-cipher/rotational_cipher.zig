const std = @import("std");
const mem = std.mem;
const ascii = std.ascii;

// Rotate text by shiftKey; caller owns the returned memory
pub fn rotate(allocator: mem.Allocator, text: []const u8, shiftKey: u5) mem.Allocator.Error![]u8 {
    var result: []u8 = try allocator.alloc(u8, text.len);

    if (shiftKey == 0 or shiftKey == 26) {
        @memcpy(result, text);
    } else {
        for (text, 0..) |c, i| {
            if (ascii.isAlphabetic(c)) {
                var new: u8 = c + shiftKey;
                if (ascii.isUpper(c)) {
                    if (!ascii.isUpper(new)) new -= 26;
                } else {
                    if (!ascii.isLower(new)) new -= 26;
                }
                result[i] = new;
            } else {
                result[i] = c;
            }
        }
    }

    return result;
}
