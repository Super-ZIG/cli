# **[SuperZIG](https://github.com/Super-ZIG)** \ CLI 🚀

A lightweight and efficient **Command Line Interface (CLI)** library for the **ZIG** programming language.  

Easily manage commands, options, and arguments in your CLI applications. 🖥️

## Features ✨

- **📋 Command Management**  
    > Define and handle commands with ease.
  
- **🛠️ Option Parsing**  
    > Support for short and long options, with or without values.
  
- **❗ Required Options**  
    > Enforce the presence of required options for commands.

- **🔎 Debugging Support**  
    > Built-in debugging to simplify development.

- **📦 Single File Usage**  
    > Use the lightweight version directly by dragging `cli.lite.zig` into your project.


## Usage 📖

> Here's how to use **SuperZIG CLI** in your projects:

- ### **1. Define Commands and Options**

    > Start by defining your commands and their associated options.

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

- ### **2. Start the CLI Application**

    > Pass your commands, options, and enable/disable debugging.

    ```zig
    pub fn main() !void
    {
        try cli.start(&g_commands, &g_options, true);
        //                                     ^ to enable debugging
    }
    ```

- ### **3. Run Your CLI**

    > Compile and execute your application:

    ```bash
    ./your_app init -t lib --name myLib
    ```

    _**RESULT**_

    ```bash
    Detected command: 'init'

    - 'init' command
       'type' option => 'lib'
       'name' option => 'myLib'

    Command executed successfully: 'init'
    ```
---

- ## Installation 📦

    > You can use the library in two ways :

    - ### **Option 1: Single File Integration**

        - Download the [`cli.lite.zig`](./dist/cli.lite.zig) file.  
        
        - Add it to your project directory.  
        
        - Import it in your code:

        ```zig
        const cli = @import("path/to/your/cli.lite.zig");
        ```

    - ### **Option 2: Zig Dependency**

        1. Add the dependency to `build.zig.zon`:

            > **Replace** `_version` _with_ **last version**.

            > **Replace** `_hash` _with_ **hash provided by zig builder**.

            ```zig
            .dependencies = 
            .{
                .cli = 
                .{
                    .url    = "https://github.com/Super-ZIG/cli/archive/refs/tags/_version.tar.gz",
                    .hash   = "_hash"
                },
            };
            ```

        2. Modify your `build.zig` file:

            > Add the following after declaring the executable. 

            ```zig
            const cli = b.dependency("cli",
            .{
                .target     = target,
                .optimize   = optimize,
            });

            exe.root_module.addImport("cli", cli.module("cli"));
            ```

        3. Import the library in your code:

            ```zig
            const cli = @import("cli");
            ```

- ## [Documentation 📚](./docs/readme.md)

    > For detailed information, visit the [`/docs`](./docs/readme.md) folder.

    ---

    - ### Support the Project ❤️

        > If you enjoy using **SuperZIG** and want to support its development, consider buying me a coffee or sending a small donation!
        
        > Your support helps me dedicate more time to improving this project and creating more amazing tools for the community :)

        - [Donate via **✨ PayPal**](https://www.paypal.me/MaysaraElshewehy)
          
          _OR_

        - [Buy me a coffee on **☕ Ko-fi**](https://ko-fi.com/codeguild)

        Thank you for your generosity and encouragement! 💖
    ---
    
    - ### Testing

        ```bash
        zig test test.zig     # run tests
        zig build try         # try examples
        ```

    - ### Contributing 🤝

        > Contributions are always welcome! Feel free to open issues, fork the repository, or submit pull requests.

        - Fork the project.
        - Create your feature branch.
        - Write tests and Testing.
        - Commit your changes.
        - Push to the branch.
        - Open a pull request.

    - ### Author 💻

        > If you encounter any problems or have any suggestions, please feel free to contact me at :

        - 📧 `Email` [maysara.elshewehy@gmail.com](mailto:mmaysara.elshewehy@gmail.com)  
        
        - 🌐 `GitHub` [github.com/maysara-elshewehy](https://github.com/maysara-elshewehy)  


    - ### License 📄

        This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

    - ##### TODO

        > .. ?

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).
