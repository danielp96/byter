module testbench();
    reg enable;
    reg opEn;
    reg [11:0] pc;
    reg [11:0] in;
    wire [11:0] out;

    pc_add PCADD(enable, opEn, pc, in, out);

    initial begin
        enable=0; opEn=0; pc=12'h000; in=12'h000;

        $display("\nenable\topEn\tpc\tin\tout");
        $monitor("%b\t%b\t%h\t%h\t%h\t", enable, opEn, pc, in, out);

        #2 enable=0; opEn=0; pc=12'h0F0; in=12'hA00;
        #2 enable=0; opEn=1; pc=12'h0F0; in=12'hA00;
        #2 enable=1; opEn=0; pc=12'h0F0; in=12'hA00;
        #2 enable=1; opEn=1; pc=12'h0F0; in=12'hA00;

        #2 $finish;
    end


endmodule