module flags (
    input clk,
    input enabled,
    input reset,
    input C_in, Z_in,
    output reg C_out, Z_out
);

    always @(posedge clk, reset)
    begin

        if (enabled) begin

            C_out = C_in;
            Z_out = Z_in;

        end

        if (reset) begin
            C_out = 0;
            Z_out = 0;
        end

    end

endmodule