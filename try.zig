// ╔══════════════════════════════════════ FILE ══════════════════════════════════════╗

    const std       = @import("std");
    const io        = @import("./src/libs/io.zig");
    const cliMin    = @import("./dist/cli.min.zig");
    const cliFull   = @import("./src/cli.zig");
    const cli       = cliFull;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    const str   = []const u8;
    const types = cli.types;

    // List of commands
    const g_commands    = [_]types.command
    {
        types.command
        {
            .name   = "test",                           // Name of the command
            .func   = &g_functions.commands.testFN,     // Function associated with the command
            .req    = &.{ "option1", "option2" },       // Required options for 'test' command
            .opt    = &.{ "option3" },                  // Optional options for 'test' command
        },

        types.command
        {
            .name   = "help",                           // Name of the command
            .func   = &g_functions.commands.helpFN,     // Function associated with the command
        }
    };

    // List of options
    const g_options     = [_]types.option
    {
        types.option
        {
            .name   = "option1",
            .short  = '1',
            .long   = "option1",
        },

        types.option
        {
            .name   = "option2",
            .short  = '2',
            .long   = "option2",
        },

        types.option
        {
            .name   = "option3",
            .short  = '3',
            .long   = "option3",
            .func   = &g_functions.options.option3FN
        },
    };

    const g_functions   = struct
    {
        pub const commands = struct
        {
            pub fn testFN(_options: []const types.option) bool
            {
                io.out("> test") catch unreachable;

                for(_options) |option|
                {
                    io.outWith("    {s} = '{s}' \n", .{option.name, option.value}) catch unreachable;
                }

                return true;
            }

            pub fn helpFN(_: []const types.option) bool
            {
                io.out("> help") catch unreachable;

                return true;
            }
        };

        pub const options = struct
        {
            pub fn option3FN(_val : str) bool
            {
                io.outWith("    => [option3FN] _val = '{s}' \n", .{ _val }) catch unreachable;

                return true;
            }
        };
    };
    
    pub fn main() !void
    {
        TRY("cli");
        {
            try cli.start(&g_commands, &g_options, true);
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ MORE ══════════════════════════════════════╗

    pub fn TRY (_msg: []const u8) void
    {
        io.cls() catch unreachable;

        io.outWith("[TRY] ==> [{s}] \n", .{ _msg }) catch unreachable;
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝