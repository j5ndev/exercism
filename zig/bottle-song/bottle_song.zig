const fixedBufferStream = @import("std").io.fixedBufferStream;
const toLower = @import("std").ascii.toLower;
pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    var take = take_down;
    var pos = start_bottles;
    if (start_bottles > 10) {
        pos = 10;
    }
    if (pos - take < 0) {
        take = pos;
    }
    const numbers = [_][]const u8{
        "no",
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
        "Ten",
    };

    var fbs = fixedBufferStream(buffer);
    const fbsw = fbs.writer();
    const stop: u32 = pos - take;
    while (pos > stop) : (pos -= 1) {

        // Write newlines if this is not the first verse
        if (fbs.pos > 0) fbsw.writeAll("\n\n") catch unreachable;

        // Write the verse
        const format =
            \\{s} green bottle{s} hanging on the wall,
            \\{s} green bottle{s} hanging on the wall,
            \\And if one green bottle should accidentally fall,
            \\There'll be {c}{s} green bottle{s} hanging on the wall.
        ;
        const number = numbers[pos];
        var number_part: []const u8 = "s";
        if (pos == 1) {
            number_part = "";
        }
        const one_less = numbers[pos - 1];
        var one_less_part: []const u8 = "s";
        if (pos == 2) {
            one_less_part = "";
        }
        fbsw.print(format, .{ number, number_part, number, number_part, toLower(one_less[0]), one_less[1..], one_less_part }) catch unreachable;
    }
    return buffer[0..fbs.pos];
}
