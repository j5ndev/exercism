const bufPrint = @import("std").fmt.bufPrint;

// Write to a slice
// Returns the length of bytes that were written
fn write(buffer: []u8, comptime fmt: []const u8, args: anytype) usize {
    return (bufPrint(buffer, fmt, args) catch "").len;
}

pub fn recite(buffer: []u8, start_verse: u32, end_verse: u32) []const u8 {
    if (start_verse > end_verse or start_verse < 1) {
        return buffer;
    }
    const verses = [_][2][]const u8{
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
    var end: usize = 0;
    for (start_verse - 1 .. end_verse) |i| {

        // Write a newline if this is not the first verse
        if (end > 0) end += write(buffer[end..], "\n", .{});

        // Write the start of the verse
        end += write(buffer[end..], "This is", .{});
    
        // Write each part of the verse
        for (0 .. i + 1) |j| {
            const verse: [2][]const u8 = verses[i - j];
            end += write(buffer[end..], " the {s} that {s}", .{ verse[0], verse[1] });
        }
    }
    return buffer[0 .. end];
}
