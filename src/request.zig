const std = @import("std");

pub const Request = struct {
    _reader: std.net.Stream.Reader,

    pub fn init(reader: std.net.Stream.Reader) Request {
        return Request{
            ._reader = reader,
        };
    }

    pub fn process(self: Request) !void {
        try self._reader.read(self._stream_buffer);
        std.debug.print("{s}", .{self._stream_buffer});
    }
};
