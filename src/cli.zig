// ╔══════════════════════════════════════ FILE ══════════════════════════════════════╗

    const std       = @import("std");
    const io        = @import("./libs/io.zig");
    pub const types = @import("./types/all.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    pub const Error = error {
        NoArgsProvided,
        UnknownCommand,
        UnknownOption,
        MissingRequiredOption,
        UnexpectedArgument,
        CommandExecutionFailed,
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Starts the CLI application.
    pub fn start ( _commands: anytype, _options: anytype, _debug: bool ) !void {
        if (comptime false) @compileError("This function must run at runtime!");

        // Create a general-purpose allocator for managing memory during execution
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};

        // - Ensures that `gpa` is properly cleaned up (memory released) when the function ends.
        defer _ = gpa.deinit();

        // - `allocator` is a reference to the allocator created by `gpa`, used for memory operations.
        const allocator = gpa.allocator();

        // Retrieve the command-line arguments in a cross-platform manner
        const args = try std.process.argsAlloc(allocator);

        // - Frees the memory allocated for the `args` array once it's no longer needed.
        defer std.process.argsFree(allocator, args);

        // If no command is provided, return an error
        if (args.len < 2) {
            try io.out("No command provided by user!");

            return Error.NoArgsProvided;
        }

        // Extract the name of the command (the second argument after the program name)
        const command_name = args[1];

        var detected_command: ?types.command = null;

        // Search through the list of available commands to find a match
        for (_commands) |command| {
            if (std.mem.eql(u8, command_name, command.name)) {
                detected_command = command;
                break;
            }
        }

        // If no matching command is found, return an error
        if (detected_command == null) {
            try io.outWith("Unknown command: {s}\n", .{command_name});

            return Error.UnknownCommand;
        }

        // Retrieve the matched command from the optional variable
        const command = detected_command.?;

        if(_debug) {
            try io.outWith("Detected command: {s}\n", .{command.name});
        }

        // Allocate memory for detected options based on remaining arguments
        var detected_options: []types.option = try allocator.alloc(types.option, args.len - 2);

        // - Ensures that memory allocated for `detected_options` is freed after usage.
        defer allocator.free(detected_options);

        // - Counter to keep track of the number of detected options.
        var detected_len : usize = 0;

        // - Starts parsing options from the third argument (index 2).
        var i: usize = 2;

        // Parsing options to capture their values
        while (i < args.len) {
            const arg = args[i];

            if (arg[0] == '-') {
                const option_name = if (arg.len > 2 and arg[1] == '-') arg[2..] else arg[1..];

                var matched_option: ?types.option = null;

                for (_options) |option| {
                    if (std.mem.eql(u8, option_name, option.long) or (option_name.len == 1 and option_name[0] == option.short)) {
                        matched_option = option;
                        break;
                    }
                }

                if (matched_option == null) {
                    try io.outWith("Unknown option: {s}\n", .{arg});
                    return Error.UnknownOption;
                }

                var option = matched_option.?;

                // Detect the value for the option
                if (i + 1 < args.len and args[i + 1][0] != '-') {
                    option.value = args[i + 1];
                    i += 1;             // Skip the value in the next iteration
                } else {
                    option.value = "";  // No value provided
                }

                detected_options[detected_len] = option;
                detected_len += 1;
            }
            else {
                try io.outWith("Unexpected argument: {s}\n", .{arg});
                return Error.UnexpectedArgument;
            }

            i += 1;
        }

        // Slice the detected options to the actual number of detected options
        const used_options = detected_options[0..detected_len];

        // Ensure all required options for the detected command are provided
        for (command.req) |req_option| {
            // - Flag to check if the required option is found.
            var found = false;

            for (used_options) |option| {
                if (std.mem.eql(u8, req_option, option.name)){
                    found = true; break;
                }
            }

            if (!found) {
                try io.outWith("Missing required option: {s}\n", .{req_option});
                return Error.MissingRequiredOption;
            }
        }

        // Execute the command's associated function with the detected options
        if (!command.func(used_options)) { return Error.CommandExecutionFailed; }
        else {
            // Execute option functions
            for (used_options) |option| {
                // Function Defined ?
                if(option.func == null) continue;
                
                // Call the function associated with the option
                const result = option.func.?(option.value);

                if (!result) {
                    try io.outWith("Option function execution failed: {s}\n", .{option.name});
                    return Error.CommandExecutionFailed;
                }
            }
        }

        // If execution reaches this point, the command was executed successfully
        if(_debug) {
            try io.outWith("Command executed successfully: {s}\n", .{command.name});
        }
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝