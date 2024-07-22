const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return initAllergenSet(score).contains(allergen);
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    var result = EnumSet(Allergen).init(.{});
    if (0b00000001 & score != 0) result.insert(.eggs);
    if (0b00000010 & score != 0) result.insert(.peanuts);
    if (0b00000100 & score != 0) result.insert(.shellfish);
    if (0b00001000 & score != 0) result.insert(.strawberries);
    if (0b00010000 & score != 0) result.insert(.tomatoes);
    if (0b00100000 & score != 0) result.insert(.chocolate);
    if (0b01000000 & score != 0) result.insert(.pollen);
    if (0b10000000 & score != 0) result.insert(.cats);
    return result;
}
