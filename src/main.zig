const std = @import("std");
const Socket = @import("config.zig").Socket;
const Request = @import("request.zig").Request;

pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const host = [4]u8{ 127, 0, 0, 1 };
    const port: u16 = 3490;

    const sock = try Socket.init(host, port);

    try stdout.print("Starting the server", .{});
    try stdout.flush();

    var server = try sock.listen();
    const connection = try server.accept();

    var buffer: [1024]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0;
    }
    var reader = connection.stream.reader(&buffer);

    const interface = reader.interface();

    _ = try interface.take(64);

    std.debug.print("{any}\n", .{buffer});
    std.debug.print("{any}\n", .{interface.bufferedLen()});
}
