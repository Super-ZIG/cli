// ╔══════════════════════════════════════ LOAD ══════════════════════════════════════╗

    const   std         = @import("std");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    pub fn build
    ( b: *std.Build )
    void
    {
        const   target      = b.standardTargetOptions(.{});
        const   optimize    = b.standardOptimizeOption(.{});

        _                   = b.addModule("cli", .{ .root_source_file = b.path("src/cli.zig") });

        const   exe         = b.addExecutable(
        .{
            .name                   = "cli",
            .root_source_file       = b.path("try.zig"),
            .target                 = target,
            .optimize               = optimize,
            .strip                  = true, 
        });

        exe.linkLibC();

        b.installArtifact(exe);

        const try_cmd       = b.addRunArtifact(exe);

        try_cmd.step.dependOn(b.getInstallStep());

        if (b.args) |args|
        {
            try_cmd.addArgs(args);
        }

        const try_step      = b.step("try", "Try the app");
        try_step.dependOn(&try_cmd.step);

        // var main_tests      = b.addTest(
        // .{
        //     .root_source_file       = b.path("test.zig"),
        //     .target                 = target,
        //     .optimize               = optimize,
        //     .link_libc              = true,
        // });

        // const test_step     = b.step("test", "Try library tests");
        // test_step.dependOn(&main_tests.step);
        
        // use zig test test.zig instead !
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝
