const mem = @import("std").mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    const rna = try allocator.alloc(u8, dna.len);
    for (dna, 0..) |d,i| rna[i] = switch (d) {
                                    'G' => 'C',
                                    'C' => 'G',
                                    'T' => 'A',
                                    'A' => 'U',
                                    else => continue,};
    return rna;
}
