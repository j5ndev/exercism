pub fn convert(buffer: []u8, n: u32) []const u8 {
    var index: usize = 0;
    if (n % 3 == 0) index = writeToBuffer(buffer, "Pling", index);
    if (n % 5 == 0) index = writeToBuffer(buffer, "Plang", index);
    if (n % 7 == 0) index = writeToBuffer(buffer, "Plong", index);

    // Write number to buffer if nothing was written
    if (index == 0) {
        var num: u32 = n;
        while (num != 0) {
            // Shift already written digits to the right
            for (0..index) |i| {
                buffer[index - i] = buffer[index - i - 1];
            }
            // Write next digit
            buffer[0] = '0' + @as(u8, @intCast(num % 10));
            index += 1;
            num = num / 10;
        }
    }
    return buffer[0..index];
}

fn writeToBuffer(buffer: []u8, s: []const u8, index: usize) usize {
    var i: usize  = index;
    for (s) |c| {
        buffer[i] = c;
        i += 1;
    }
    return i;
}
