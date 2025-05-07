const fixedBufferStream = @import("std").io.fixedBufferStream;

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    if (start_verse > end_verse or start_verse < 1) {
        return buffer;
    }

    const parts = [_][2][]const u8{
        .{ "first", "a Partridge in a Pear Tree." },
        .{ "second", "two Turtle Doves" },
        .{ "third", "three French Hens" },
        .{ "fourth", "four Calling Birds" },
        .{ "fifth", "five Gold Rings" },
        .{ "sixth", "six Geese-a-Laying" },
        .{ "seventh", "seven Swans-a-Swimming" },
        .{ "eighth", "eight Maids-a-Milking" },
        .{ "ninth", "nine Ladies Dancing" },
        .{ "tenth", "ten Lords-a-Leaping" },
        .{ "eleventh", "eleven Pipers Piping" },
        .{ "twelfth", "twelve Drummers Drumming" },
    };

    var fbs = fixedBufferStream(buffer);
    const fbsw = fbs.writer();
    for (start_verse - 1..end_verse) |i| {

        // Write a newline if this is not the first verse
        if (fbs.pos > 0) fbsw.writeAll("\n") catch unreachable;

        // Write the start of the verse
        fbsw.print("On the {s} day of Christmas my true love gave to me:", .{parts[i][0]}) catch unreachable;

        // Write each part of the verse except the first day
        if (i > 0) {
            for (0..i) |j| {
                fbsw.print(" {s},", .{parts[i - j][1]}) catch unreachable;
            }
            fbsw.writeAll(" and") catch unreachable;
        }

        // Write the part from the first day
        fbsw.print(" {s}", .{parts[0][1]}) catch unreachable;
    }
    return buffer[0..fbs.pos];
}
