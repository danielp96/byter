module stack (
    input clk,
    input reset,
    input enable,
    input w_enable,
    input [11:0] data_in,
    output [11:0] data_out
);

    reg [11:0] stack [8];
    reg [2:0] n;

    assign data_out = enable && !w_enable? stack[n]: data_in;

    always @(posedge ~clk)
    begin

        // pop
        if (enable && !w_enable)
        begin   
            n = n-1;
        end
    end

    always @(posedge clk)
    begin
        // push
        if (enable && w_enable)
        begin
            n = n+1;
            stack[n] = data_in;
        end
    end

    always @(posedge reset)
    begin
        if (reset)
        begin
            n = 3'h7;
            stack[0] = 12'h0_00;
            stack[1] = 12'h0_00;
            stack[2] = 12'h0_00;
            stack[3] = 12'h0_00;
            stack[4] = 12'h0_00;
            stack[5] = 12'h0_00;
            stack[6] = 12'h0_00;
            stack[7] = 12'h0_00;
        end
    end

endmodule