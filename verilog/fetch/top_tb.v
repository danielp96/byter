`define simulation

module testbench();

    reg clk;
    reg enabled;
    reg reset;
    reg [7:0] in_data;
    wire [7:0] out_data;

    fetch Fetch(clk, enabled, reset, in_data, out_data);

    initial begin
        clk=0;
        enabled=0; reset=0; in_data=0;

        $display("clk\tenabled\treset\tin_data\tout_data");
        $monitor("%d\t%d\t%d\t%h\t%h\t", clk, enabled, reset, in_data, out_data);

        #1 enabled=0; reset=0; in_data=8'h3f;
        #4 enabled=1; reset=0; in_data=8'ha2;
        #4 enabled=1; reset=0; in_data=8'h34;
        #4 enabled=1; reset=1; in_data=8'h83;
        #4 $finish;
    end

    always begin
        #2 clk = ~clk;
    end


endmodule
