pub fn isPangram(str: []const u8) bool {
    var letters: u26 = 0;
    for (str) |l| {
        switch (l) {
            'a'...'z' => letters |= @as(u26, 1) << @intCast(l - 'a'),
            'A'...'Z' => letters |= @as(u26, 1) << @intCast(l - 'A'),
            else => continue,
        }
    }
    return letters == comptime ~@as(u26, 0);
}