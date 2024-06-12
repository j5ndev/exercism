pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    var sum: u64 = 0;
    for (1..(n/2)+1) |i| {
        if (n % i == 0) sum += i;
    }
    if (n < sum) {
        return .abundant;
    } else  if (n == sum) {
        return .perfect;
    } else {
        return .deficient;
    }
}
