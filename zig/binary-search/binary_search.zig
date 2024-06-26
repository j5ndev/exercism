pub fn binarySearch(comptime T: type, target: usize, items: []const T) ?usize {
    var l: usize = 0;
    var r: usize = items.len;
    while (l < r) {
        const m = (l + r) / 2;
        if (target > items[m]) {
            l = m + 1;
        } else if (target < items[m]) {
            r = m;
        } else {
            return m;
        }
    }
    return null;
}
