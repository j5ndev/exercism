const std = @import("std");
const mem = std.mem;

pub const ConversionError = error{
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit,
};

/// Converts `digits` from `input_base` to `output_base`, returning a slice of digits.
/// Caller owns the returned memory.
pub fn convert(
    allocator: mem.Allocator,
    digits: []const u32,
    input_base: u32,
    output_base: u32,
) (mem.Allocator.Error || ConversionError)![]u32 {
    if (input_base <= 1) return ConversionError.InvalidInputBase;
    if (output_base <= 1) return ConversionError.InvalidOutputBase;

    var v: u32 = 0;
    for (digits) |d| {
        if (input_base <= d) return ConversionError.InvalidDigit;
        v = input_base * v + d;
    }

    var result = std.ArrayList(u32).init(allocator);
    errdefer result.deinit();
    if (v == 0) {
        try result.append(0);
    } else {
        while (v > 0) : (v /= output_base) try result.insert(0, v % output_base);
    }
    return result.toOwnedSlice();
}
