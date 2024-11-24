# **[SuperZIG](https://github.com/Super-ZIG)** \ **[CLI](../../README.md)** \ **[Docs](../readme.md)** \ **`Error`**

- #### **Definition**

    Enum of errors.

- #### **Prototype**

    ```zig
    pub const Error = error
    {
        NoArgsProvided,
        UnknownCommand,
        UnknownOption,
        MissingRequiredOption,
        UnexpectedArgument,
        CommandExecutionFailed,
    };
    ```

- #### **Example**

    ```zig
    cli.Error.?
    ```

- ##### Related

  - ###### [`cli.start`](../func/start.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).