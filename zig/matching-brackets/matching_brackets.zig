const std = @import("std");
const mem = std.mem;

pub fn isBalanced(allocator: mem.Allocator, s: []const u8) !bool {
    var stack = std.ArrayList(u8).init(allocator);
    defer stack.deinit();

    for (s) |c| {
        try switch(c) {
            '(' => |v| stack.append(v),
            ')' => if ('(' != stack.popOrNull() orelse return false) return false,
            '{' => |v| stack.append(v),
            '}' => if ('{' != stack.popOrNull() orelse return false) return false,
            '[' => |v| stack.append(v),
            ']' => if ('[' != stack.popOrNull() orelse return false) return false,
            else => continue,
        };
    }
    return stack.items.len == 0;
}
