const fixedBufferStream = @import("std").io.fixedBufferStream;

pub fn convert(buffer: []u8, n: u32) []const u8 {
    var stream = fixedBufferStream(buffer);
    var writer = stream.writer();
    if (n % 3 == 0) writer.writeAll("Pling") catch unreachable;
    if (n % 5 == 0) writer.writeAll("Plang") catch unreachable;
    if (n % 7 == 0) writer.writeAll("Plong") catch unreachable;
    if (stream.pos == 0) writer.print("{}", .{n}) catch unreachable;
    return stream.getWritten();
}
