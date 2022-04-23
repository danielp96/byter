`define simulation

module testbench();

    reg [11:0] addr;
    wire [7:0] data;

    rom ROM(addr, data);

    initial begin
        addr=0;
        $display("addr\tdata\t");
        $monitor("%d\t%h", addr, data);

        #1 addr=1;
        #1 addr=2;
        #1 addr=3;
        #1 addr=4;
        #1 addr=5;
        #1 addr=6;
        #1 addr=7;

    end

endmodule