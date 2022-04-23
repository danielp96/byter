module reg_module (
    input clk,
    input reset,
    input regEnable, litEnable, memEnable,
    input [3:0] SA, SB,
    input [7:0] data, lit,
    output [7:0] A, B,
    output [11:0] pcAddData
);

    reg [7:0] registers [16];

    assign A = registers[memEnable? 15: SA];
    assign B = registers[memEnable? 15: SB];
    assign pcAddData = {registers[13][3:0], registers[12]};

    always @(posedge clk)
    begin

        if (regEnable && !litEnable && !memEnable)
        begin
            // 
            registers[SA] = data; 
        end


        if (regEnable && litEnable)
        begin
            registers[14] = lit;
        end


        if (regEnable && memEnable)
        begin
            registers[15] = data;
        end
    end


    always @(posedge reset)
    begin
        registers[00] = 8'h00;
        registers[01] = 8'h00;
        registers[02] = 8'h00;
        registers[03] = 8'h00;
        registers[04] = 8'h00;
        registers[05] = 8'h00;
        registers[06] = 8'h00;
        registers[07] = 8'h00;
        registers[08] = 8'h00;
        registers[09] = 8'h00;
        registers[10] = 8'h00;
        registers[11] = 8'h00;
        registers[12] = 8'h00;
        registers[13] = 8'h00;
        registers[14] = 8'h00;
        registers[15] = 8'h00;
    end

endmodule