module fetch (
    input clk,
    input enable,
    input reset,
    input [15:0] in_data,
    output reg [15:0] out_data
);

    always @(posedge clk, posedge reset)
    begin

        if (enable) begin

            out_data = in_data;

        end

        if (reset) begin
            out_data = 16'h00_00;
        end

    end

endmodule