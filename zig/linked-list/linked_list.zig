pub fn LinkedList(comptime T: type) type {
    _ = T;
    return struct {
        const Self = @This();
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: ?usize = null,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        // Add node to the end of the list
        pub fn push(self: *Self, node: *Node) void {
            if (self.last) |n| {
                n.next = node;
                node.prev = n;
            } else {
                self.first = node;
            }
            self.last = node;
            self.len += 1;
        }

        // Remove node from the end of the list
        pub fn pop(self: *Self) ?*Node {
            const result = self.last;
            if (result) |n| {
                self.last = n.prev;
                if (self.first == result) self.first = null;
                n.next = null;
                n.prev = null;
                self.len -= 1;
            }
            return result;
        }

        // Remove node from the start of the list
        pub fn shift(self: *Self) ?*Node {
            const result = self.first;
            if (result) |n| {
                self.first = n.next;
                if (self.first == null) self.last = null;
                n.prev = null;
                n.next = null;
                self.len -= 1;
            }
            return result;
        }

        // Add node to the start of the list
        pub fn unshift(self: *Self, node: *Node) void {
            if (self.first) |n| {
                node.next = n;
                n.prev = node;
            } else {
                self.last = node;
            }
            self.first = node;
            self.len += 1;
        }

        // Remove node from anywhere in the list
        pub fn delete(self: *Self, node: *Node) void {
            var current: ?*Node = self.first;
            while (current) |n| : (current = n.next) {
                if (n == node) {
                    if (n.prev) |p| {
                        p.next = n.next;
                    } else {
                        self.first = n.next;
                    }
                    if (n.next) |q| {
                        q.prev = n.prev;
                    } else {
                        self.last = n.prev;
                    }
                    n.next = null;
                    n.prev = null;
                    self.len -= 1;
                    break;
                }
            }
        }
    };
}
