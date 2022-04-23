module alu (
    input [7:0] A, B,
    input [3:0] S,
    input [2:0] n,
    input C_in,
    output [7:0] Y,
    output C, Z
);

    reg [8:0] temp;

    assign Y = temp[7:0];
    assign C = temp[8];
    assign Z = (temp[7:0] == 0);

    always @(A, B, S, n, C_in)
    begin

        case(S)
            4'b0000: temp[7:0] = B;                     // pass B
            4'b0001: temp = { C_in, A & B};             // A and B
            4'b0010: temp = { C_in, A | B};             // A or B
            4'b0011: temp = { C_in, ~B};                // not B
            4'b0100: temp = { C_in, A ^ B};             // A xor B
            4'b0101: temp = A + B;                      // sum A B
            4'b0110: temp = A - B;                      // sub A B
            4'b0111: temp = {C_in, B[3:0], B[7:4]};     // swap nibbles
            4'b1000: temp = {C_in, B[6:0], 1'b0};       // left shift, no carry
            4'b1001: temp = {B, C_in};                  // left shift through carry
            4'b1010: temp = {C_in, 1'b0, B[7:1]};       // right shift, no carry
            4'b1011: temp = {B[0], C_in, B[7:1]};       // right shift through carry
            4'b1100: temp = B+1;                        // increase B
            4'b1101: temp = B-1;                        // decrease B
            4'b1110: temp = {C_in, A & ~(8'h01 << n)};  // clear n bit of A
            4'b1111: temp = {C_in, A | (8'h01 << n)};   // set n bit of A
            default: temp[7:0] = 0;
        endcase
    end

endmodule