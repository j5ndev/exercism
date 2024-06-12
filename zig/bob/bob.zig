const ascii = @import("std").ascii;

const State = enum {
    Question, // 0 Q
    Yelling,  // 1 Y
    YellingQ, // 2 YQ
    Silence,  // 3 S
    Else,     // 4 E
    Neutral,  // 5 N
};

const Char = enum {
    QuestionMark, // 0 ?
    Upper,        // 1 U
    Lower,        // 2 L
    Other,        // 3 O
    Whitespace,   // 4 W
};

const transition = [6][5]State {
    //       ?          U         L      O         W
    [_]State{.Question, .Else,    .Else, .Else,    .Question}, // Q
    [_]State{.YellingQ, .Yelling, .Else, .Yelling, .Yelling},  // Y
    [_]State{.YellingQ, .Yelling, .Else, .Yelling, .YellingQ}, // YQ
    [_]State{.Question, .Yelling, .Else, .Neutral, .Silence},  // S
    [_]State{.Question, .Else,    .Else, .Else,    .Else},     // E
    [_]State{.Question, .Yelling, .Else, .Neutral, .Neutral},  // N
};

fn typeOfChar(c: u8) u8{
    const t:Char = switch(c) {
        'a'...'z' => Char.Lower,
        'A'...'Z' => Char.Upper,
        '?' => Char.QuestionMark,
        ' ', '\t', '\n', '\r', ascii.control_code.vt, ascii.control_code.ff  => Char.Whitespace,
        else => Char.Other,
    };
    return @intFromEnum(t);
}

const stateMatrix = blk: {
    var v: [6][256]u8 = undefined;
    @setEvalBranchQuota(3078);
    for (0..6) |s| {
         for (0..256) |c| {
            v[s][c] = @intFromEnum(transition[s][typeOfChar(c)]);
        }
    }
    break :blk v;
};

pub fn response(s: []const u8) []const u8 {
    var stateInt:u8 = 3;
    for (s) |c| stateInt = stateMatrix[stateInt][c];
    const state: State = @enumFromInt(stateInt);
    return switch (state) {
        .Question => "Sure.",
        .Yelling => "Whoa, chill out!",
        .YellingQ => "Calm down, I know what I'm doing!",
        .Silence => "Fine. Be that way!",
        .Else, .Neutral => "Whatever.",
    };
}
