module decoder (
    input [7:0] i,
    input C, Z,
    output [3:0] S,
    output loadFlags, loadPC, incPC, csRam, weRam, regEn, litEn, memEn, csStackReg, weStackReg, csStackAddr, weStackAddr, outEnable, inEnable, eAluB, eAluY, csPCadd
);

    reg [21] out;

    assign {loadFlags, loadPC, incPC, S, csRam, weRam, regEn, litEn, memEn, csStackReg, weStackReg, csStackAddr, weStackAddr, outEnable, inEnable, eAluB, eAluY, csPCadd} = out;

    always @(i, C, Z)
    begin
        if (i[7:5] == 3'b000)
        begin
            case(i[4:0])

                // NOP
                5'b00000: out = 21'b001000000000000000000;

                // AND
                5'b00001: out = 21'b101000100100000000000;
                
                // OR
                5'b00010: out = 21'b101001000100000000000;
                
                // NOT
                5'b00011: out = 21'b101001100100000000000;
                
                // XOR
                5'b00100: out = 21'b101010000100000000000;
                
                // ADD
                5'b00101: out = 21'b101010100100000000000;
                
                // SUB
                5'b00110: out = 21'b101011000100000000000;
                
                // SWAP
                5'b00111: out = 21'b001011100100000000000;
                
                // RETURN
                5'b01000: out = 21'b010000000000001000000;
                
                // RETURNL
                5'b01001: out = 21'b010000000110001000000;
                
                // MOV
                5'b01010: out = 21'b001000000100000000000;
                
                // LSL
                5'b01011: out = 21'b101100000100000000000;
                
                // LSR
                5'b01100: out = 21'b101101000100000000000;
                
                // CSL
                5'b01101: out = 21'b101100100100000000000;
                
                // CSR
                5'b01110: out = 21'b101101100100000000000;
                
                // IN
                5'b01111: out = 21'b101000000100000001100;
                
                // OUT
                5'b10000: out = 21'b001000000000000010010;
                
                // CMP
                5'b10001: out = 21'b101011000000000000000;
                
                // INC
                5'b10010: out = 21'b101110000100000000000;
                
                // DEC
                5'b10011: out = 21'b101110100100000000000;
                
                // LIT
                5'b10100: out = 21'b001000000110000000000;
                
                // SETB
                5'b10101: out = 21'b001111100100000000000;
                
                // CLRB
                5'b10110: out = 21'b001111000100000000000;
                
                // PUSH
                5'b10111: out = 21'b001000000000110000010;
                
                // POP
                5'b11000: out = 21'b001000000100100000100;

                // PCADD
                5'b11001: out = 21'b011000000000000000001;
            endcase
        end

        if (i[7] || i[6] || i[5])
        begin
            case(i[7:4])
                
                //CALL
                4'b0010: out = 21'b010000000000001100000;
                
                //JMP
                4'b0011: out = 21'b010000000000000000000;
                
                //JC
                4'b0100: out = C? 21'b010000000000000000000: 21'b001000000000000000000;
                
                //JNC
                4'b0101: out = C? 21'b001000000000000000000: 21'b010000000000000000000;
                
                //JZ
                4'b0110: out = Z? 21'b010000000000000000000: 21'b001000000000000000000;
                
                //JNZ
                4'b0111: out = Z? 21'b001000000000000000000: 21'b010000000000000000000;
                
                //STORE
                4'b1000: out = 21'b101000011001000000010;
                
                //LOAD
                4'b1001: out = 21'b101000010101000000100;
                
            endcase

        end
    end


endmodule