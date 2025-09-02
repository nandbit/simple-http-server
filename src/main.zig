const std = @import("std");
const Socket = @import("config.zig").Socket;

pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    const address = [4]u8{ 127, 0, 0, 1 };
    const port: u16 = 3490;

    const sock = Socket.init(address, port);

    try stdout.print("address: {any}\n", .{sock.address});
    try stdout.print("port: {d}\n", .{sock.port});
    try stdout.flush();
}
