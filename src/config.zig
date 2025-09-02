const std = @import("std");

pub const Socket = struct {
    address: [4]u8,
    port: u16,

    pub fn init(address: [4]u8, port: u16) Socket {
        return Socket{
            .address = address,
            .port = port,
        };
    }
};
