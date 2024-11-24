# **[SuperZIG](https://github.com/Super-ZIG)** \ **[CLI](../../README.md)** \ **[Docs](../readme.md)** \ **`types.command`**

- #### **Definition**

    Structure to represent the type of command.

- #### **Prototype**

    ```zig
    pub const   command     = struct 
    {
        name    : str,                          // Name or description of the command
        func    : _funcType,                    // Function to execute the command
        req     : req           = &.{},         // Required options
        opt     : opt           = &.{},         // Optional options
        
        const _funcType         = *const fn ([]const option) bool;
    };
    ```

- #### **Example**

    ```zig
    const       io                          = @import("io");
    const       cli                         = @import("cli");

    const       str                         = []const u8;
    const       Option                      = cli.types.option;
    const       Command                     = cli.types.command;
    
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
                io.out("init command") catch unreachable;
                return true;
            }

            pub fn helpFN(_: []const Option) bool
            {
                io.out("help command") catch unreachable;

                return true;
            }
        };

        pub const Options = struct
        {
            pub fn nameFN(_val: str) bool
            {
                io.outWith("name option => {s} \n", .{_val}) catch unreachable;
                return true;
            }

            pub fn typeFN(_val: str) bool
            {
                io.outWith("type option => {s} \n", .{_val}) catch unreachable;
                return true;
            }
        };
    };
    ```

    ```zig
    pub fn main() !void
    {
        try cli.start(&g_commands, &g_options, true);
    }
    ```

    _**RESULT**_

    ```bash
    Detected command: 'init'

    - 'init' command
       'type' option => 'lib'
       'name' option => 'myLib'

    Command executed successfully: 'init'
    ```
- #### **Notes**

    - **Only at `Run-Time`.**

    - **Can throw errors, see [`cli.Error`](../enums/Error.md).**

- ##### Related

  - ###### [`cli.type.option`](./option.md)

  - ###### [`cli.start`](../func/start.md)

  - ###### [`cli.Error`](../enums/Error.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).