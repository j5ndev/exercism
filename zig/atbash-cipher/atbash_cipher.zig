const std = @import("std");
const mem = std.mem;
const BLOCK_SIZE: usize = 5;

/// Encodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn encode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var out: []u8 = try allocator.alloc(u8, s.len + s.len / BLOCK_SIZE);
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
    _ = allocator.resize(out, index);
     out.len = index;
    return out;
}

/// Decodes `s` using the Atbash cipher. Caller owns the returned memory.
pub fn decode(allocator: mem.Allocator, s: []const u8) mem.Allocator.Error![]u8 {
    var out: [] u8 = try allocator.alloc(u8, s.len);
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
     _ = allocator.resize(out, index);
     out.len = index;
    return out;
}
