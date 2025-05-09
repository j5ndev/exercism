const fixedBufferStream = @import("std").io.fixedBufferStream;

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    var take = take_down;
    var start = start_bottles;
    if (start_bottles < take_down) {
        take = start_bottles;
    }
    if (start_bottles > 10) {
        start = 10;
    }

    const numbers = [_][] const u8 {
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
        "ten",
    };

    var fbs = fixedBufferStream(buffer);
    const fbsw = fbs.writer();
    for (start - 1 .. start + take) |i| {
        
        // Write a newline if this is not the first verse
        if (fbs.pos > 0) fbsw.writeAll("\n") catch unreachable;

        // Write the verse
        const format = 
            \\{s} green bottles hanging on the wall
            \\{s} green bottles hanging on the wall
            \\And if one green bottle should accidentally fall,
            \\There'll be {s} green bottle{s} hanging on the wall.
        ;
        const number = numbers[i];
        var one_less = "no";
        if (i > 0) {
            one_less = numbers[i-1];
        }
        var part = "";
        if (i == 1) {
            part = "s";
        }
        //TODO: handle conditional capitalization
       fbsw.print(format, .{number, number, one_less, part}) catch unreachable;
    }
}