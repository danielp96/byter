`define simulation

module testbench();

    reg enable;
    reg [3:0] in;
    wire [3:0] out;

    buffer_tri BUFFER(enable, in, out);

    initial begin

        $display("enable\tin\tout");
        $monitor("%b\t%b\t%b\t", enable, in, out);

           enable=0; in=0;

        #2 enable=0; in=4'b0101;
        #2 enable=1; in=4'b0101;
        #2 enable=1; in=4'b1010;


    end

endmodule
