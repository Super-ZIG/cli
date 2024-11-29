// ╔══════════════════════════════════════ TYPE ══════════════════════════════════════╗

    const str = []const u8;

    /// array of string
    pub const req = []const str;

    /// array of string
    pub const opt = req;

    /// Structure to represent the type of command.
    pub const command = struct 
    {
        name : str,        // Name of the command
        func : _funcType,  // Function to execute the command                                               
        req  : req = &.{}, // Required options
        opt  : opt = &.{}, // Optional options
        
        const _funcType = *const fn ([]const option) bool;
    };

    /// Structure to represent the type of option.
    pub const option = struct
    {
        name  : str,                    // Name of the option
        func  : ?_funcType = undefined, // Function to execute the option                                               
        short : u8,                     // Short form, e.g., -n|-N
        long  : str,                    // Long form, e.g., --name
        value : str = "",               // Value of the option

        const _funcType = *const fn (str) bool;
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝