const std = @import("std");
const mem = std.mem;
const BLOCK_SIZE: usize = 5;

fn countChar(s: []const u8) usize {
    var count: usize = 0;
    for (s) |c| {
        switch (c) {
            'a'...'z', 'A'...'Z', '0'...'9' => count += 1,
            else => continue,
        }
    }
    return count;
}

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const charCount = countChar(s);
    if (charCount == 0) return try allocator.alloc(u8, 0);

    const length: usize = charCount + if (charCount % 5 == 0) charCount/BLOCK_SIZE - 1 else charCount/BLOCK_SIZE;
    const out: []u8 = try allocator.alloc(u8, length);
    var index: usize = 0;
    var blockCount: usize = 0;
    for (s) |c| {
        const encoded: u8 = switch (c) {
            'a'...'z' => |v| 'z' - (v - 'a'),
            '0'...'9' => |v| v,
            'A'...'Z' => |v| 'z' - (v - 'A'),
            else => continue,
        };
        if (blockCount == BLOCK_SIZE) {
            out[index] = ' ';
            index += 1;
            blockCount = 0;
        }
        out[index] = encoded;
        index += 1;
        blockCount += 1;
    }
    return out;
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    const out: [] u8 = try allocator.alloc(u8, countChar(s));
    var index: usize = 0;
    for (s) |c| {
        const decoded = switch (c) {
            'a'...'z' => |v| 'a' + ('z' - v),
            '0'...'9' => |v| v,
            else => continue,
        };
        out[index] = decoded;
        index += 1;
    }
    return out;
}
