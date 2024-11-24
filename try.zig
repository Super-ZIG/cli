// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const       std                         = @import("std");
    const       io                          = @import("./src/libs/io.zig");
    const       cli                         = @import("./src/cli.zig");
    // const       cli                         = @import("./dist/cli.lite.zig");        // to try the lite version (same code but in one file)
    const       testing                     = std.testing;

    const       str                         = []const u8;
    const       Option                      = cli.types.option;
    const       Command                     = cli.types.command;

// ╚══════════════════════════════════════════════════════════════════════════════════╝




// ╔══════════════════════════════════════ CONF ══════════════════════════════════════╗

    // List of commands
    const g_commands = [_]Command
    {
        Command
        {
            .name = "init",
            .func = &Functions.Commands.initFN,
            
            // Required options for 'init' command
            .req = &.{ "type", "name" },

            // Optional options for 'init' command
            // .opt = &.{},
        },

        Command
        {
            .name = "help",
            .func = &Functions.Commands.helpFN,
                        
            // Required options for 'init' command
            // .req = &.{},

            // Optional options for 'init' command
            // .opt = &.{},
        },
    };

    // List of options
    const g_options = [_]Option
    {
        Option
        {
            .name   = "type",
            .short  = 't',
            .long   = "type",
            .func   = &Functions.Options.typeFN,
        },

        Option
        {
            .name   = "name",
            .short  = 'n',
            .long   = "name",
            .func   = &Functions.Options.nameFN,
        },
    };

    pub const Functions = struct
    {
        pub const Commands = struct
        {
            pub fn initFN(_: []const Option) bool
            {
                io.out("Functions => Commands => initFN") catch unreachable;
                return true;
            }

            pub fn helpFN(_: []const Option) bool
            {
                io.out("Functions => Commands => helpFN") catch unreachable;

                return true;
            }
        };

        pub const Options = struct
        {
            pub fn nameFN(_val: str) bool
            {
                io.outWith("Functions => Options => nameFN => {s} \n", .{_val}) catch unreachable;
                return true;
            }

            pub fn typeFN(_val: str) bool
            {
                io.outWith("Functions => Options => typeFN => {s} \n", .{_val}) catch unreachable;
                return true;
            }
        };
    };
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MAIN ══════════════════════════════════════╗

    pub fn main() !void
    {
        TRY("cli");
        {
            try cli.start(&g_commands, &g_options, true);
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ____ ══════════════════════════════════════╗

    pub fn TRY (_msg: []const u8) void
    {
        io.cls() catch unreachable;

        io.outWith("[TRY] ==> [{s}] \n", .{ _msg }) catch unreachable;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
