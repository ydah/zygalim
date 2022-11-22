const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const file_name = ".github/workflows/linting.yml";
    const file = try std.fs.cwd().openFile(file_name, .{});
    defer file.close();

    const file_size = try file.getEndPos();
    try stdout.print("file size: {d}\n", .{file_size});

    var reader = std.io.bufferedReader(file.reader());
    var instream = reader.reader();

    const allocator = std.heap.page_allocator;
    const contents = try instream.readAllAlloc(allocator, file_size);
    defer allocator.free(contents);

    try stdout.print("read file value: {c}", .{contents});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
