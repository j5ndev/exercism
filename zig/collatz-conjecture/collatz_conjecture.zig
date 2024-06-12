const divExact = @import("std").math.divExact;

pub const ComputationError = error {
    IllegalArgument,
};

pub fn steps(number: usize) ComputationError!usize {
    if (number == 0) return ComputationError.IllegalArgument;
    var count:usize = 0;
    var result:usize = number;
    while (result != 1) : (count += 1) {
        result = divExact(usize, result, 2) catch 3 * result + 1;
    }
    return count;
}
