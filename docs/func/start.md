# **[SuperZIG](https://github.com/Super-ZIG)** \ **[CLI](../../README.md)** \ **[Docs](../readme.md)** \ **`Start`**

- #### **Definition**

    Starts the CLI application.

- #### **Prototype**

    ```zig
    pub fn start
    ( _commands: anytype, _options: anytype, _debug: bool ) 
    !void
    ```

- #### **Parameters**

  - `_commands`
      
      > The commands like `ziggy init` _`init` is a command._


  - `_options`
      
      > The options like `ziggy test -1 valOne -2 valTwo -3 valThree` _`-t` and `--name` is an options._


  - `_debug`
      
      > **True** to enable debug outputs, `false` to disable it.

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
            .name   = "test",                           // Name of the command
            .func   = &Functions.Commands.testFN,       // Function associated with the command
            .req    = &.{ "option1", "option2" },       // Required options for 'test' command
            .opt    = &.{ "option3" },                  // Optional options for 'test' command
        },

        Command
        {
            .name   = "help",                           // Name of the command
            .func   = &Functions.Commands.helpFN,       // Function associated with the command
        }
    };

    // List of options
    const g_options = [_]Option
    {
        Option
        {
            .name   = "option1",
            .short  = '1',
            .long   = "option1",
        },

        Option
        {
            .name   = "option2",
            .short  = '2',
            .long   = "option2",
        },

        Option
        {
            .name   = "option3",
            .short  = '3',
            .long   = "option3",
            .func   = &Functions.Options.option3FN
        },
    };

    pub const Functions = struct
    {
        pub const Commands = struct
        {
            pub fn testFN(_options: []const Option) bool
            {
                io.out("> test") catch unreachable;

                for(_options) |option|
                {
                    io.outWith("    {s} = '{s}' \n", .{option.name, option.value}) catch unreachable;
                }

                return true;
            }

            pub fn helpFN(_: []const Option) bool
            {
                io.out("> help") catch unreachable;

                return true;
            }
        };

        pub const Options = struct
        {
            pub fn option3FN(_val : str) bool
            {
                io.outWith("    => [option3FN] _val = '{s}' \n", .{ _val }) catch unreachable;

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
    # ./your_app test -1 valOne -2 valTwo -3 valThree

    Detected command: 'test'

    > 'test'
        option1 = 'valOne' 
        option2 = 'valTwo' 
        option3 = 'valThree' 
        => [option3FN] _val = 'valThree' 

    Command executed successfully: 'test'
    ```

- #### **Notes**

    - **Only at `Run-Time`.**

    - **Can throw errors, see [`cli.Error`](../enums/Error.md).**

- ##### Related

  - ###### [`cli.type.command`](../types/command.md)

  - ###### [`cli.type.option`](../types/option.md)

  - ###### [`cli.Error`](../enums/Error.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).