const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var is_windows = false;
    if (target.os_tag == null) {
        is_windows = builtin.os.tag == .windows;
    } else if (target.os_tag == .windows) {
        is_windows = true;
    }

    const exe = b.addExecutable(.{
        .name = "hello",
        .target = target,
        .optimize = optimize,
    });

    const c_files = .{
        "src/main.c",
    };
    const c_flags = .{
        "-Wall",
        "-Wextra",
        "-Werror",
        "-pedantic",
    };

    exe.addCSourceFiles(&c_files, &c_flags);
    exe.linkLibC();

    if (is_windows) {
        exe.linkSystemLibrary("user32");
        exe.linkSystemLibrary("shell32");
    }

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
