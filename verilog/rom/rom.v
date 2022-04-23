module rom (
    input [11:0] addr,
    output [15:0] data
);

    reg [15:0] mem [0:4095];

    assign data = mem[addr];

    initial begin
        $readmemb("rom.list", mem);
    end

endmodule