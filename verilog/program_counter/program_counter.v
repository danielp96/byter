module program_counter(
    input clk,
    input enable,
    input reset,
    input load,
    input [11:0] pre_load,
    output reg [11:0] pc
);

    always @(posedge clk, posedge reset)
    begin

        if (load) begin
            pc = pre_load;
        end

        if (enable) begin
            pc = pc + 1;
        end

        if (reset) begin
            pc = 0;
        end
    end
endmodule