
module testbench();

    reg clk;
    reg reset;
    reg enable;
    reg [3:0] addr;
    reg [7:0] in_data;
    wire [8:0] out_00, out_01, out_02, out_03, out_04, out_05, out_06, out_07, out_08, out_09, out_10, out_11, out_12, out_13, out_14, out_15;

    out Out(clk, reset, enable, addr, in_data, out_00, out_01, out_02, out_03, out_04, out_05, out_06, out_07, out_08, out_09, out_10, out_11, out_12, out_13, out_14, out_15);

    initial begin
        clk=0;
        enable=0; reset=0; addr=4'h0; in_data=0;

        $display("\nclk\tenable\treset\taddr\tin_data\tout_00\tout_01\tout_02\tout_03");
        $monitor("%d\t%d\t%d\t%h\t%h\t%h\t%h\t%h\t%h", clk, enable, reset, addr, in_data, out_00, out_01, out_02, out_03);

        #1 enable=0; reset=1; addr=4'h0; in_data=8'h0f;
        #4 enable=1; reset=0; addr=4'h0; in_data=8'h02;
        #4 enable=1; reset=0; addr=4'h1; in_data=8'h04;
        #4 enable=1; reset=0; addr=4'h2; in_data=8'hc0;
        #4 enable=1; reset=0; addr=4'h3; in_data=8'haa;
        #4 $finish;
    end

    always begin
        #2 clk = ~clk;
    end



endmodule
