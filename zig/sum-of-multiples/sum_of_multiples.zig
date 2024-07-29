const std = @import("std");
const mem = std.mem;

pub fn sum(allocator: mem.Allocator, factors: []const u32, limit: u32) !u64 {
    var multiples = try std.DynamicBitSet.initEmpty(allocator, limit);
    defer multiples.deinit();
    for (factors) |f| if (f != 0) {
        var m = f;
        while (m < limit) : (m += f) multiples.set(m);
    };
    var result: u64 = 0;
    var iterator = multiples.iterator(.{});
    while (iterator.next()) |m| result += m;
    return result;
}
