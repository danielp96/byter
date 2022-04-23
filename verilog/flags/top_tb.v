`define simulation

module testbench();

    reg clk;
    reg enabled;
    reg reset;
    reg C_in, Z_in;
    wire C_out, Z_out;

    flags Flags(clk, enabled, reset, C_in, Z_in, C_out, Z_out);

    initial begin
        clk=0;
        enabled=0; reset=0; C_in=0; Z_in=0;

        $display("clk\tenabled\treset\tC_in\tZ_in\tC_out\tZ_out");
        $monitor("%d\t%d\t%d\t%d\t%d\t%d\t%d\t", clk, enabled, reset, C_in, Z_in, C_out, Z_out);

        #1 enabled=0; reset=0; C_in=0; Z_in=0;
        #4 enabled=1; reset=0; C_in=1; Z_in=0;
        #4 enabled=1; reset=0; C_in=1; Z_in=1;
        #4 enabled=1; reset=1; C_in=0; Z_in=0;
        #4 $finish;
    end





    always begin
        #2 clk = ~clk;
    end

endmodule
