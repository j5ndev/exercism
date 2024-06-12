pub const Coordinate = struct {
    x: f32,
    y: f32,
    pub fn init(x: f32, y: f32) Coordinate {
        return Coordinate {.x = x, .y = y};
    }
    pub fn score(self: Coordinate) usize {
        const r2: f32 = self.x * self.x + self.y * self.y;
        if (r2 <= 1) return 10;
        if (r2 <= 25) return 5;
        if (r2 <= 100) return 1;
        return 0;
    }
};
