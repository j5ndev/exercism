pub const Plant = enum {
    clover,
    grass,
    radishes,
    violets,
};

fn plantFromCode(c: u8) Plant {
    return switch (c) {
        'C' => .clover,
        'G' => .grass,
        'R' => .radishes,
        'V' => .violets,
        else => unreachable,
    };
}

pub fn plants(diagram: []const u8, student: []const u8) [4]Plant {
    const indexRow1 = (student[0] - 'A') * 2;
    const indexRow2 = indexRow1 + (diagram.len / 2 + 1);
    return .{
        plantFromCode(diagram[indexRow1]),
        plantFromCode(diagram[indexRow1 + 1]),
        plantFromCode(diagram[indexRow2]),
        plantFromCode(diagram[indexRow2 + 1]),
    };
}
