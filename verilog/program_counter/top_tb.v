`define simulation

module testbench();

    reg clk;
    reg enable;
    reg [11:0] pre_load;
    reg load;
    reg reset;
    wire [11:0] value;


    program_counter PC(clk, enable, reset, load, pre_load, value);

    initial begin
        clk=0; enable=0; pre_load=0; load=0; reset=0;

        $display("clk\tenable\treset\tload\t_preload\tvalue");
        $monitor("%b\t%b\t%b\t%b\t%d\t%d\t",clk , enable, reset, load, pre_load, value);

        #5 enable=1; pre_load=15; load=0; reset=0;
        #2 enable=1; pre_load=15; load=0; reset=0;

        #30 enable=1; pre_load=15; load=1; reset=0;
        #2  enable=1; pre_load=15; load=0; reset=0;

        #10 enable=1; pre_load=15; load=0; reset=1;

        #20 $finish;
    end

    always begin
        #2 clk = ~clk;
    end


endmodule
