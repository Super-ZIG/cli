// This is lite version of https://github.com/Super-ZIG/io lib.
// I created this file to use this lib wihtout need to install it using zig, just drag this single file into your project and import it.
// The lite version currently does not support on/once functions !
//
// Made with ❤️ by Maysara.
//
// Email    : Maysara.Elshewehy@gmail.com
// GitHub   : https://github.com/maysara-elshewehy



// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const       std                         = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔═════════════════════════════════════ OUTPUT ═════════════════════════════════════╗

    /// Outputs a simple message followed by a newline.
    pub inline fn out
    ( comptime _msg: []const u8 ) 
    !void 
    {
        try outWith(_msg ++ "\n", .{});
    }

    /// Outputs a formatted message to the console.
    pub inline fn outWith
    ( comptime _fmt: []const u8, _args: anytype ) 
    !void 
    {
        try nosuspend std.io.getStdOut().writer().print(_fmt, _args);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MORE ══════════════════════════════════════╗

    /// Clears the terminal(Screen).
    pub inline fn cls
    () 
    !void 
    {
        _ = try out("\x1b[2J\x1b[H");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
