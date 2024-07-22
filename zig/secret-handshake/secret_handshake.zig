const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u4) {
    wink = 1,
    double_blink = 2,
    close_your_eyes = 4,
    jump = 8,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var result = std.ArrayList(Signal).init(allocator);
    errdefer result.deinit();
    inline for (std.meta.fields(Signal)) |f| {
        if (f.value & number != 0) try result.append(@enumFromInt(f.value));
    }
    if (16 & number != 0) mem.reverse(Signal, result.items);
    return result.toOwnedSlice();
}
