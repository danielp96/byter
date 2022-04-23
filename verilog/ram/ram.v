module ram
(
    input enable,
    input write_enable,
    input [11:0] address,  // addres
    inout [7:0] data    // data
);

    reg [7:0] mem [0:4095];
    reg [7:0] out_data;

    // read  -> enable=1 & write_enable=0
    // write -> enable=1 & write_enable=1

    assign data = (enable & ~write_enable)?out_data:8'bzzzz_zzzz;

    always @ (enable, write_enable, address, data)
    begin

        // WRITE
        if (enable & write_enable) 
        begin
            mem[address] = data;
        end

        // READ
        if (enable & ~write_enable)
        begin
            out_data = mem[address];
        end

    end

    // for testing purposes
    initial begin

        mem[12'b000000000000] = 8'b1010_1010;
    end

endmodule