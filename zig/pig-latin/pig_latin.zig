const std = @import("std");
const mem = std.mem;

pub fn translate(allocator: mem.Allocator, phrase: []const u8) mem.Allocator.Error![]u8 {
    var buffer = std.ArrayList(u8).init(allocator);
    errdefer buffer.deinit();
    if (phrase.len == 0) {
        return buffer.toOwnedSlice();
    }
    const first_letter = phrase[0];
    var second_letter:u8 = ' ';
    if (phrase.len > 1) {
        second_letter = phrase[1];
    }

    // Rule 1: begins with vowel, "xr" or "yt", then append "ay"
    sw: switch (first_letter) {
        'a', 'e', 'i', 'o', 'u' => {
            try buffer.appendSlice(phrase);
            try buffer.appendSlice("ay");
            return buffer.toOwnedSlice();
        },
        'x' => if (second_letter == 'r') continue :sw 'a',
        'y' => if (second_letter == 't') continue :sw 'a',
        else => {},
    }

    // Begins with consonant
    var previous_all_consonants = true;
    var previous_letter:u8 = first_letter;
    for (phrase[1..], 1..) |letter, i| {

        // Rule 3: 
        if (letter == 'u' and previous_letter == 'q' and previous_all_consonants) {
            try buffer.appendSlice(phrase[(i+1)..]);
            try buffer .appendSlice(phrase[

        }
        previous_letter = letter;
        switch (previous_letter) {
            'a', 'e', 'i', 'o', 'u' => {
                previous_all_consonants = false;
            },
            else => {},
        }
    }

    return buffer.toOwnedSlice();
}
