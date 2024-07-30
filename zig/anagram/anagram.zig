const std = @import("std");
const mem = std.mem;
const toLower = std.ascii.toLower;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var result = std.BufSet.init(allocator);
    errdefer result.deinit();
    const h = histogram(word);
    for (candidates) |c| if (eq(h, histogram(c)) and !same(word, c)) try result.insert(c);
    return result;
}

fn histogram(word: []const u8) [27]u8 {
    var result = [_]u8 {0}**27;
    for (word) |c| result[toLower(c) - 97] += 1;
    return result;
}

fn eq(h1: [27] u8, h2: [27] u8) bool {
    for (h1, h2) |v1, v2| if (v1 != v2) return false;
    return true;
}

fn same(w1: []const u8, w2: []const u8) bool {
    for (w1, w2) |c1, c2| if (toLower(c1) != toLower(c2)) return false;
    return true;
}