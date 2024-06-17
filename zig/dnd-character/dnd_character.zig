const std = @import("std");

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var lowest:i8 = 6;
    var sum:i8 = 0;
    for (0..4) |_| {
        const roll = std.crypto.random.intRangeAtMost(i8, 1, 6);
        if (roll < lowest) lowest = roll;
        sum += roll;
    }
    return sum - lowest;
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        return Character {
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
       };
    }
};
