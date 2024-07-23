const std = @import("std");

pub const Category = enum(u8) {
    ones = 1,
    twos = 2,
    threes = 3,
    fours = 4,
    fives = 5,
    sixes = 6,
    full_house,
    four_of_a_kind,
    little_straight,
    big_straight,
    choice,
    yacht,
};

pub fn score(dice: [5]u3, category: Category) u32 {
    var result: u32 = 0;

    var ds: [5]u3 = undefined;
    @memcpy(&ds, &dice);
    std.mem.sort(u3, &ds, {}, comptime std.sort.asc(u3));

    switch (category) {
        .ones, .twos, .threes, .fours, .fives, .sixes => |v| {
            const i = @intFromEnum(v);
            for (ds) |d| {
                if (d == i) result += i;
            }
        },
        .full_house => {
            if ((ds[0] == ds[2] and ds[2] != ds[3] and ds[3] == ds[4])
             or (ds[0] == ds[1] and ds[1] != ds[2] and ds[2] == ds[4])) {
                for (ds) |d| result += d;
            }
        },
        .four_of_a_kind => {
            if (ds[0] == ds[3] or ds[1] == ds[4]) result = @as(u32, ds[1]) * 4;
        },
        .little_straight => {
            if (ds[0] == 1 and ds[1] == 2 and ds[2] == 3 and ds[3] == 4 and ds[4] == 5) result = 30;
        },
        .big_straight =>  {
            if (ds[0] == 2 and ds[1] == 3 and ds[2] == 4 and ds[3] == 5 and ds[4] == 6) result = 30;
        },
        .choice => {
            for (ds) |d| result += d;
        },
        .yacht => {
            if (ds[0] == ds[4]) result = 50;
        },

    }
    return result;
}
