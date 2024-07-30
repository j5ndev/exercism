const std = @import("std");
const mem = std.mem;
const isAlpha = std.ascii.isAlphabetic;
const isDigit = std.ascii.isDigit;

// Returns an array with word separators identified
// Intended for use at comptime
fn separators() [256] u8 {
    var result = [_]u8{' '} ** 256;
    for (0..256) |i| {
        switch(i) {
            'A'...'Z', 'a'...'z', '0'...'9', '\'' => {},
            else => result[i] = i,
        }
    }
    return result;
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var result = std.StringHashMap(u32).init(allocator);
    errdefer result.deinit();

    var iter = std.mem.splitAny(u8, s, comptime separators()[0..]);
    while(iter.next()) |word| if (word.len > 0) {
        var buffer = std.ArrayList(u8).init(allocator);
        for (word, 0..) |c, i| {
            if ( c == '\'' and (i == 0 or i == word.len - 1)) continue;
            try buffer.append(std.ascii.toLower(c));
        }
        if (buffer.items.len == 0) {
            buffer.deinit();
            continue;
        }
        const item = try result.getOrPut(buffer.items);
        if (item.found_existing) {
            buffer.deinit();
            item.value_ptr.* += 1;
        } else {
            try result.put(try buffer.toOwnedSlice(), 1);
        }
    };
    return result;
}