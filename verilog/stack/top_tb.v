
module testbench ();
    reg clk;
    reg reset;
    reg enable;
    reg w_enable;
    reg [3:0] data_in;
    wire [3:0] data_out;

    stack_8x4 Stack(clk, reset, enable, w_enable, data_in, data_out);

    initial begin
        clk=0; reset=0; enable=0; w_enable=0; data_in=4'h0;
        $display("\nclk\treset\tenable\tw_enable\tdata_in\tdata_out");
        $monitor("%b\t%b\t%b\t%b\t\t%h\t%h\t", clk, reset, enable, w_enable, data_in, data_out);
        #1 reset=1;
        #2 reset=0;
        #2 enable=0; w_enable=0; data_in=4'hF;
        #2 enable=0; w_enable=1; data_in=4'hF;
        #2 enable=1; w_enable=1; data_in=4'hF;

        #2 enable=0; w_enable=1; data_in=4'h7;
        #2 enable=1; w_enable=1; data_in=4'h7;

        #2 enable=0; w_enable=1; data_in=4'ha;
        #2 enable=1; w_enable=1; data_in=4'ha;

        #2 enable=0; w_enable=1; data_in=4'h4;
        #2 enable=1; w_enable=1; data_in=4'h4;

        #2 enable=0; w_enable=1; data_in=4'h1;
        #2 enable=1; w_enable=1; data_in=4'h1;

        #2 enable=0; w_enable=1; data_in=4'h9;
        #2 enable=1; w_enable=1; data_in=4'h9;

        #2 enable=0; w_enable=1; data_in=4'hc;
        #2 enable=1; w_enable=1; data_in=4'hc;

        #2 enable=0; w_enable=1; data_in=4'h8;
        #2 enable=1; w_enable=1; data_in=4'h8;

        #2 enable=0; w_enable=1; data_in=4'h3;
        #2 enable=1; w_enable=1; data_in=4'h3;
        

        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        #2 enable=0; w_enable=0; data_in=4'h0;
        #2 enable=1; w_enable=0; data_in=4'h0;
        


        #2 $finish;
    end

    always begin
        #2 clk = ~clk;
    end


    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, Stack);
    end

endmodule