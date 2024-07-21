const std = @import("std");
const mem = std.mem;

pub const Signal = enum {
    close_your_eyes,
    double_blink,
    jump,
    wink,
};

pub fn calculateHandshake(allocator: mem.Allocator, number: u5) mem.Allocator.Error![]const Signal {
    var result = std.ArrayList(Signal).init(allocator);
    errdefer result.deinit();

    if (0b00001 & number != 0) try result.append(.wink);
    if (0b00010 & number != 0) try result.append(.double_blink);
    if (0b00100 & number != 0) try result.append(.close_your_eyes);
    if (0b01000 & number != 0) try result.append(.jump);
    if (0b10000 & number != 0) mem.reverse(Signal, result.items);

    return result.toOwnedSlice();
}
