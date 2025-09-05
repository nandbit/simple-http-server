const std = @import("std");
const Socket = @import("config.zig").Socket;
const Request = @import("request.zig").Request;

pub fn main() !void {
    const host = [4]u8{ 127, 0, 0, 1 };
    const port: u16 = 3490;

    const sock = try Socket.init(host, port);

    var server = try sock.listen();
    const connection = try server.accept();
    defer server.deinit();
    defer connection.stream.close();

    // Allocator
    // var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    // defer arena.deinit();
    //
    // const allocator = arena.allocator();

    // Buffers
    var reader_buffer: [1024]u8 = undefined;
    var writer_buffer: [1024]u8 = undefined;

    for (0..reader_buffer.len) |i| {
        reader_buffer[i] = 0;
    }
    for (0..writer_buffer.len) |i| {
        writer_buffer[i] = 0;
    }

    var reader = connection.stream.reader(&reader_buffer);
    const reader_interface = reader.interface();

    // const data = reader_interface.allocRemaining(allocator, .limited(reader_buffer.len)) catch |err| {
    //     std.debug.print("Error: {any}\n", .{err});
    //     return err;
    // };

    while (true) {
        _ = reader_interface.peek(1) catch |err| {
            std.debug.print("End of Stream: {any}\n", .{err});
            connection.stream.close();
        };
    }
    //
    // var writer: std.Io.Writer = .fixed(&writer_buffer);
    // const data = try reader_interface.stream(&writer, .unlimited);
    //
    // connection.stream.close();
    // std.debug.print("{s}\n", .{data});
    // var read_byte: []u8 = undefined;
    // while (true) {
    //     read_byte = interface.take(1) catch |err| {
    //         std.debug.print("End of stream, {any}", .{err});
    //         break;
    //     };
    //     std.debug.print("{any}\n", .{read_byte});
    // }

}
