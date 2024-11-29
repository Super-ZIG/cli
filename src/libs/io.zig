// This is a min version of https://github.com/Super-ZIG/io library.
// I created this file to use this library without the need to install it via Zig. 
// Simply drag this single file into your project and import it.
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
