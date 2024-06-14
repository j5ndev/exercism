pub fn isPangram(str: []const u8) bool {
    var letters: u26 = 0;
    for (str) |c| {
        switch (c) {
            'a'...'z' => letters |= @as(u26, 1) << @intCast(c - 'a'),
            'A'...'Z' => letters |= @as(u26, 1) << @intCast(c - 'A'),
            else => continue,
        }
    }
    return letters == comptime ~@as(u26, 0);
}