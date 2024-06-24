const std = @import("std");

pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    var set = std.bit_set.ArrayBitSet(u32, limit + 1).initEmpty();
    var buffer_index: u32 = 0;
    var number: u32 = 2;
    while (number <= limit) : (number += 1) {
        if (!set.isSet(number)) {

            // Record prime number
            buffer[buffer_index] = @intCast(number);
            buffer_index += 1;

            // Mark multiples
            var multiple: u32 = 2 * number;
            while (multiple <= limit) : (multiple += number) {
                set.set(multiple);
            }
        }
    }
    return buffer[0..buffer_index];
}
