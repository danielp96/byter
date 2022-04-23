module out_module (
    input clk,
    input reset,
    input enable,
    input [3:0] addr,
    input [7:0] in_data,
    output [7:0] out_00, out_01, out_02, out_03, out_04, out_05, out_06, out_07, out_08, out_09, out_10, out_11, out_12, out_13, out_14, out_15
);
    
    reg [7:0] out [16];

    assign out_00 = out[00];
    assign out_01 = out[01];
    assign out_02 = out[02];
    assign out_03 = out[03];
    assign out_04 = out[04];
    assign out_05 = out[05];
    assign out_06 = out[06];
    assign out_07 = out[07];
    assign out_08 = out[08];
    assign out_09 = out[09];
    assign out_10 = out[10];
    assign out_11 = out[11];
    assign out_12 = out[12];
    assign out_13 = out[13];
    assign out_14 = out[14];
    assign out_15 = out[15];


    always @(posedge clk)
    begin

        if (enable) begin

            out[addr] = in_data;

        end
    end

    always @(posedge reset)
    begin
        if (reset) begin
            out[00] = 8'b00;
            out[01] = 8'b00;
            out[02] = 8'b00;
            out[03] = 8'b00;
            out[04] = 8'b00;
            out[05] = 8'b00;
            out[06] = 8'b00;
            out[07] = 8'b00;
            out[08] = 8'b00;
            out[09] = 8'b00;
            out[10] = 8'b00;
            out[11] = 8'b00;
            out[12] = 8'b00;
            out[13] = 8'b00;
            out[14] = 8'b00;
            out[15] = 8'b00;
        end

    end

endmodule