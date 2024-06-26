pub fn binarySearch(comptime T: type, target: usize, items: []const T) ?usize {
    var left: usize = 0;
    var right: usize = items.len;
    while (left < right) {
        const middle = (left + right) / 2;
        if (target > items[middle]) {
            left = middle + 1;
        } else if (target < items[middle]) {
            right = middle;
        } else {
            return middle;
        }
    }
    return null;
}
