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

- **⚙️ Optional Options**  
    > Provide flexibility to commands by allowing additional configuration without being mandatory.

- **🌍 Platform Compatibility**
    > Supports Windows, Linux and macOS.
  
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
    const       types                       = cli.types;
    
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
    ./your_app test -1 valOne -2 valTwo -3 valThree
    ```

    _**RESULT**_

    ```bash
    Detected command: 'test'

    > 'test'
        option1 = 'valOne' 
        option2 = 'valTwo' 
        option3 = 'valThree' 
        => [option3FN] _val = 'valThree' 

    Command executed successfully: 'test'
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

        - . . . ?

    - ##### Related
        
        - [SuperZIG IO](https://github.com/Super-ZIG/io)
      
---


Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).
