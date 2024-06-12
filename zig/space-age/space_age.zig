pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const earthYearSeconds: f64 = 31_557_600;
        const planetSeconds: f64 = switch (self) {
            .mercury => comptime 0.2408467 * earthYearSeconds,
            .venus => comptime 0.61519726 * earthYearSeconds,
            .earth => comptime earthYearSeconds,
            .mars => comptime 1.8808158 * earthYearSeconds, 
            .jupiter => comptime 11.862615 * earthYearSeconds,
            .saturn => comptime 29.447498 * earthYearSeconds,
            .uranus => comptime 84.016846 * earthYearSeconds,
            .neptune => comptime 164.79132 * earthYearSeconds,
        };
        return @as(f64, @floatFromInt(seconds)) / planetSeconds;
    }
};
