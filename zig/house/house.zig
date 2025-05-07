const fixedBufferStream = @import("std").io.fixedBufferStream;

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    if (start_verse > end_verse or start_verse < 1) {
        return buffer;
    }
    const parts = [_][2][]const u8{
        .{"house", "Jack built."},
        .{"malt", "lay in"},
        .{"rat", "ate"},
        .{"cat", "killed"},
        .{"dog", "worried"},
        .{"cow with the crumpled horn", "tossed"},
        .{"maiden all forlorn", "milked"},
        .{"man all tattered and torn", "kissed"},
        .{"priest all shaven and shorn", "married"},
        .{"rooster that crowed in the morn", "woke"},
        .{"farmer sowing his corn", "kept"},
        .{"horse and the hound and the horn", "belonged to"},
    };

    var fbs = fixedBufferStream(buffer);
    const fbsw = fbs.writer();
    for (start_verse - 1 .. end_verse) |i| {

        // Write a newline if this is not the first verse
        if (fbs.pos > 0) fbsw.writeAll("\n") catch unreachable;

        // Write the start of the verse
       fbsw.writeAll("This is") catch unreachable;
    
        // Write each part of the verse
        for (0 .. i + 1) |j| {
            const part: [2][]const u8 = parts[i - j];
            fbsw.print(" the {s} that {s}", .{ part[0], part[1] }) catch unreachable;
        }
    }
    return buffer[0 .. fbs.pos];
}
