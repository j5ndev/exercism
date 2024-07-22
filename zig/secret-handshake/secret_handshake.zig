const std = @import("std");
const mem = std.mem;

pub const Signal = enum(u8) {
    wink = 0b00001,
    double_blink = 0b00010,
    close_your_eyes = 0b00100,
    jump = 0b01000,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var result = std.ArrayList(Signal).init(allocator);
    errdefer result.deinit();
    inline for (std.meta.fields(Signal)) |f| {
        if (f.value & number != 0) try result.append(@enumFromInt(f.value));
    }
    if (0b10000 & number != 0) mem.reverse(Signal, result.items);
    return result.toOwnedSlice();
}
