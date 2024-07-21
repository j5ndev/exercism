const std = @import("std");
const mem = std.mem;

pub fn abbreviate(allocator: mem.Allocator, words: []const u8) mem.Allocator.Error![]u8 {
    var buffer = std.ArrayList(u8).init(allocator);
    errdefer buffer.deinit();
    var next:bool = true;
    for (words) |c| {
        switch(c) {
            ' ', '-', '_' => next = true,
            else => if (next) {
                        try buffer.append(std.ascii.toUpper(c));
                        next = false;
                    }
        }
    }
    return buffer.toOwnedSlice();
}
