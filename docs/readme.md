# **[SuperZIG](https://github.com/Super-ZIG)** \ **[CLI](../README.md)** \ Documentation 📚

| index                     |
| ------------------------- |
| [Functions](#functions)   |
| [Structures](#structures) |
| [Types](#types)           |

---

- ## Functions

- [start ( `_commands`, `_options`, `_debug` )](./func/start.md)
    
    > Starts the CLI application.

    ```zig
    pub inline fn start
    ( _commands: anytype, _options: anytype, _debug: bool )
    !void
    ```

  > _.. ?_


- ## Structures

  - [command](./types/command.md)
    
    > _Structure to represent the type of command._

  - [option](./types/option.md)
    
    > _Structure to represent the type of option._

- ## Types

  - [req](./types/req.md) and [opt](./types/opt.md)
    
    > _Alias type equal array of string `[]const []const u8`_.

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).
