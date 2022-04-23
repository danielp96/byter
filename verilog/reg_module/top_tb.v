module testbench();

    reg clk;
    reg reset;
    reg regEn, litEn, memEn;
    reg [3:0] SA, SB;
    reg [7:0] data, lit;
    wire [7:0] A, B;
    wire [12:0] pcAddData;

    reg_module RMOD(clk, reset, regEn, litEn, memEn, SA, SB, data, lit, A, B, pcAddData);

    initial begin
       clk=0; reset=0; regEn=0; litEn=0; memEn=0; SA=4'h0; SB=4'h0; data=8'h00; lit=8'h00;

       $display("\nclk\treset\tregEn\tlitEn\tmemEn\tSA\tSB\tdata\tlit\tA\tB");
       $monitor("%b\t%b\t%b\t%b\t%b\t%h\t%h\t%h\t%h\t%h\t%h\t", clk, reset, regEn, litEn, memEn, SA, SB, data, lit, A, B);

       #1 reset=1;
       #2 reset=0;
       #2 regEn=1; litEn=0; memEn=0; SA=4'h0; SB=4'h1; data=8'h11; lit=8'h00;
       #2 regEn=0; litEn=0; memEn=0; SA=4'h3; SB=4'h0; data=8'h00; lit=8'h44;
       #2 regEn=1; litEn=0; memEn=0; SA=4'h1; SB=4'h0; data=8'hff; lit=8'h44;
       #2 regEn=0; litEn=0; memEn=0; SA=4'h0; SB=4'h1; data=8'hff; lit=8'h44;

       #2 regEn=1; litEn=1; memEn=0; SA=4'h0; SB=4'he; data=8'hff; lit=8'h44;
       #2 regEn=0; litEn=0; memEn=0; SA=4'h0; SB=4'he; data=8'hff; lit=8'h44;

       #2 regEn=1; litEn=0; memEn=1; SA=4'h0; SB=4'hf; data=8'h88; lit=8'h00;
       #2 regEn=0; litEn=0; memEn=0; SA=4'h0; SB=4'hf; data=8'h88; lit=8'h00;

       #2 $finish;
    end


    always
    begin
        #2 clk=~clk;
    end

endmodule