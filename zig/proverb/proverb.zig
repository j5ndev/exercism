const std = @import("std");
const mem = std.mem;
const fmt = std.fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var result = try allocator.alloc([]u8, words.len);
    errdefer allocator.free(result);
    if (words.len == 0) return result;
    for (words[0..words.len-1], 0..) |word, i| {
        result[i] = try fmt.allocPrint(allocator, "For want of a {s} the {s} was lost.\n", .{word, words[i+1]});
    }
    result[words.len - 1] = try fmt.allocPrint(allocator, "And all for the want of a {s}.\n", .{words[0]});
    return result;
}
