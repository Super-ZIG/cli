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
      
      > The options like `ziggy init -t lib --name myLib` _`-t` and `--name` is an options._


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

  - ###### [`cli.type.command`](../types/command.md)

  - ###### [`cli.type.option`](../types/option.md)

  - ###### [`cli.Error`](../enums/Error.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).