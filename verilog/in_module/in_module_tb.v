module testbench();
    reg enable;
    reg [3:0] addr;
    reg [7:0] in_00, in_01, in_02, in_03, in_04, in_05, in_06, in_07, in_08, in_09, in_10, in_11, in_12, in_13, in_14, in_15;
    wire [7:0] out;

    in_module IN(enable, addr, in_00, in_01, in_02, in_03, in_04, in_05, in_06, in_07, in_08, in_09, in_10, in_11, in_12, in_13, in_14, in_15, out);

    initial begin
        enable=0; addr=4'h0; in_00=8'h00; in_01=8'h00; in_02=8'h00; in_03=8'h00;
        $display("\nen\taddr\tin0\tin1\tin2\tin3\tout");
        $monitor("%b\t%h\t%h\t%h\t%h\t%h\t%h", enable, addr, in_00, in_01, in_02, in_03, out);

        #2 enable=0; addr=4'h0; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;
        #2 enable=1; addr=4'h0; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;

        #2 enable=0; addr=4'h1; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;
        #2 enable=1; addr=4'h1; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;

        #2 enable=0; addr=4'h2; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;
        #2 enable=1; addr=4'h2; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;

        #2 enable=0; addr=4'h3; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;
        #2 enable=1; addr=4'h3; in_00=8'h11; in_01=8'h44; in_02=8'haa; in_03=8'hff;

        #2 $finish;

    end

endmodule