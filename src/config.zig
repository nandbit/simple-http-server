const std = @import("std");

pub const Socket = struct {
    _address: std.net.Address,
    _stream: std.net.Stream,

    pub fn init(host: [4]u8, port: u16) !Socket {
        const address = std.net.Address.initIp4(host, port); // Parses an IP address which may include a port
        const socket = try std.posix.socket(
            address.any.family, // domain
            std.posix.SOCK.STREAM, // socket_type
            std.posix.IPPROTO.TCP, // protocol
        );
        const stream = std.net.Stream{ .handle = socket }; // A cross-platform socket wrapper

        return Socket{
            ._address = address,
            ._stream = stream,
        };
    }

    pub fn listen(self: Socket) std.net.Address.ListenError!std.net.Server {
        return try std.net.Address.listen(self._address, .{
            .kernel_backlog = 128,
            .reuse_address = false,
            .force_nonblocking = false,
        });
    }
};
