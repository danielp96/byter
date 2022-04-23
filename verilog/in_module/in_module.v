module in_module (
    input enable,
    input [3:0] addr,
    input [7:0] in_00, in_01, in_02, in_03, in_04, in_05, in_06, in_07, in_08, in_09, in_10, in_11, in_12, in_13, in_14, in_15,
    output reg [7:0] out
);

    wire [7:0] in [16];

    assign in[00] = in_00;
    assign in[01] = in_01;
    assign in[02] = in_02;
    assign in[03] = in_03;
    assign in[04] = in_04;
    assign in[05] = in_05;
    assign in[06] = in_06;
    assign in[07] = in_07;
    assign in[08] = in_08;
    assign in[09] = in_09;
    assign in[10] = in_10;
    assign in[11] = in_11;
    assign in[12] = in_12;
    assign in[13] = in_13;
    assign in[14] = in_14;
    assign in[15] = in_15;

    always @(enable, addr, in_00, in_01, in_02, in_03, in_04, in_05, in_06, in_07, in_08, in_09, in_10, in_11, in_12, in_13, in_14, in_15)
    begin
        out = enable?in[addr]:8'bzzzz_zzzz;
    end

endmodule