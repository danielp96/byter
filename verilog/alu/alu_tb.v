module alu_tb ();
    reg [7:0] A, B;
    reg [3:0] S;
    reg [2:0] n;
    reg C_in;
    wire [7:0] Y;
    wire C, Z;
    reg [7:0] expected;
    integer countTotal, countPass, countFail;
    integer logFile;

    alu Alu(A, B, S, n, C_in, Y, C, Z);

    initial begin
        // test result counters
        countTotal=0; countPass=0; countFail=0;
        logFile = $fopen("alu.log", "w");
        log(logFile, $sformatf("Test Name: %s, Module Tested: %s\n", "Alu Test", "Alu"));

        // initial state
        S=4'b0000; A=8'b0000_0000; B=8'b0000_0000; C_in=0; n=3'b000;
        #1
        // $display("\nS\tA\t\tB\t\tC_in\tn\tY\t\tC\tZ");
        // $monitor("%b\t%b\t%b\t%b\t%d\t%b\t%b\t%b\t", S, A, B, C_in, n, Y, C, Z);

        // logic operations
        expected = testPassB(8'b0000_0010, 8'b0000_0001);
        #1 logResult(logFile, "Pass B", Y==expected);

        expected = testAnd(8'b0000_0011, 8'b0000_0110);
        #1 logResult(logFile, "AND", Y==expected);

        expected = testOr(8'b0000_0011, 8'b0000_0110);
        #1 logResult(logFile, "OR", Y==expected);

        expected = testNot(8'b1111_1111, 8'b0000_0000);
        #1 logResult(logFile, "NOT", Y==expected);

        expected = testXor(8'b1111_1111, 8'b0101_1010);
        #1 logResult(logFile, "XOR", Y==expected);


        // add
        expected = testAdd(8'b0000_1111, 8'b0110_0001);
        #1 logResult(logFile, "ADD", Y==expected);

        expected = testAdd(8'b0000_1111, 8'b1111_0001);
        #1 logResult(logFile, "ADD overflow", Y==expected);


        // sub
        expected = testSub(8'b0000_1000, 8'b0000_0001);
        #1 logResult(logFile, "SUB", Y==expected);

        expected = testSub(8'b0000_0000, 8'b0000_0001);
        #1 logResult(logFile, "SUB underflow", Y==expected);

        expected = testSub(8'b0000_0001, 8'b0000_0001);
        #1 logResult(logFile, "SUB zero", Y==expected);


        // swap nibbles
        expected = testSwap(8'b1001_0110, 8'b1111_0000);
        #1 logResult(logFile, "SWAP", Y==expected);

        // left shift, no carry
        expected = testLeftShift(8'b1001_0110, 8'b1000_1111);
        #1 logResult(logFile, "Left Shift no carry", Y==expected);

        // left shift, carry
        expected = testLeftShiftCarry(8'b1001_0110, 8'b1000_1111, 0);
        #1 logResult(logFile, "Left Shift with carry", Y==expected);

        expected = testLeftShiftCarry(8'b1001_0110, 8'b0000_1111, 1);
        #1 logResult(logFile, "Left Shift with carry", Y==expected);


        // right shift, no carry
        expected = testRightShift(8'b1001_0110, 8'b1111_0001);
        #1 logResult(logFile, "Right Shift no carry", Y==expected);

        // right shift, carry
        expected = testLeftShiftCarry(8'b1001_0110, 8'b1111_0001, 0);
        #1 logResult(logFile, "Right Shift with carry", Y==expected);

        expected = testLeftShiftCarry(8'b1001_0110, 8'b1111_0000, 0);
        #1 logResult(logFile, "Right Shift with carry", Y==expected);

        // increase B
        expected = testIncrease(8'b1001_0110, 8'b0000_0011);
        #1 logResult(logFile, "Increase B", Y==expected);

        expected = testIncrease(8'b1001_0110, 8'b1111_1111);
        #1 logResult(logFile, "Increase B overflow", Y==expected);

        // decrease B
        expected = testDecrease(8'b1001_0110, 8'b0000_0011);
        #1 logResult(logFile, "Decrease B", Y==expected);

        expected = testDecrease(8'b1001_0110, 8'b0000_0000);
        #1 logResult(logFile, "Decrease B underflow", Y==expected);

        // clear n bit of B
        expected = testClearBit(8'b1111_1111, 3'b000);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b001);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b010);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b011);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b100);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b101);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b110);
        #1 logResult(logFile, "Clear Bit", Y==expected);

        expected = testClearBit(8'b1111_1111, 3'b111);
        #1 logResult(logFile, "Clear Bit", Y==expected);


        // set n bit of B
        expected = testSetBit(8'b0000_0000, 3'b000);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b001);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b010);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b011);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b100);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b101);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b110);
        #1 logResult(logFile, "Set Bit", Y==expected);

        expected = testSetBit(8'b0000_0000, 3'b111);
        #1 logResult(logFile, "Set Bit", Y==expected);

        log(logFile, $sformatf("Total: %d, Pass: %d, Fail: %d\n", countTotal, countPass, countFail));

        $fclose(logFile);
        #2 $finish();
    end

    function void log(integer file, string msg);
        $write(msg);
        $fwrite(file, msg);

    endfunction

    function void logResult(integer file, input string name, input logic result);
        string padding;
        string status;
        string msg;
        integer target_width;
        begin
            if (result) begin
                countPass++;
                status = "PASS";
            end else begin
                countFail++;
                status = "FAIL";
            end

            countTotal++;

            // calculate padding
            target_width = 25;
            padding = "";
            for (int i = 0; i < (target_width - name.len()); i++) begin
                padding = {padding, " "};
            end

            // format output
            msg = $sformatf("%s: %s,%s S=%b, A=%b, B=%b, C_in=%b, n=%b, Y=%b, C=%b, Z=%b\n",
                status, name, padding, S, A, B, C_in, n, Y, C, Z);

            log(file, msg);
        end
    endfunction

    // set the alu inputs
    function void setInput(
            input [3:0] _S,
            input [7:0] _A,
            input [7:0] _B,
            input _C,
            input [3:0] _n
        );
        begin
            S=_S; A=_A; B=_B; C_in=_C; n=_n;
        end
    endfunction

    function [7:0] testPassB(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0000, _A, _B, 0, 0);
            return _B;
        end
    endfunction

    function [7:0] testAnd(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0001, _A, _B, 0, 0);
            return _A & _B;
        end
    endfunction

    function [7:0] testOr(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0010, _A, _B, 0, 0);
            return _A | _B;
        end
    endfunction

    function [7:0] testNot(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0011, _A, _B, 0, 0);
            return ~_B;
        end
    endfunction

    function [7:0] testXor(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0100, _A, _B, 0, 0);
            return _A ^ _B;
        end
    endfunction

    // set the inputs for an addition and calculate expected value
    function [7:0] testAdd(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0101, _A, _B, 0, 0);
            return _A + _B;
        end
    endfunction

    // set the inputs for an substraction and calculate expected value
    function [7:0] testSub(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0110, _A, _B, 0, 0);
            return _A - _B;
        end
    endfunction

    function [7:0] testSwap(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b0111, _A, _B, 0, 0);
            return {B[3:0], B[7:4]};
        end
    endfunction

    function [7:0] testLeftShift(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b1000, _A, _B, 0, 0);
            return {B[6:0], 1'b0};
        end
    endfunction

    function [7:0] testLeftShiftCarry(
            input [7:0] _A,
            input [7:0] _B,
            input _C
        );
        begin
            setInput(4'b1001, _A, _B, _C, 0);
            return {B[6:0], _C};
        end
    endfunction

    function [7:0] testRightShift(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b1010, _A, _B, 0, 0);
            return {1'b0, B[7:1]};
        end
    endfunction

    function [7:0] testRightShiftCarry(
            input [7:0] _A,
            input [7:0] _B,
            input _C
        );
        begin
            setInput(4'b1011, _A, _B, _C, 0);
            return {_C, B[7:1]};
        end
    endfunction

    function [7:0] testIncrease(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b1100, _A, _B, 0, 0);
            return _B + 1;
        end
    endfunction

    function [7:0] testDecrease(
            input [7:0] _A,
            input [7:0] _B
        );
        begin
            setInput(4'b1101, _A, _B, 0, 0);
            return _B - 1;
        end
    endfunction

    function [7:0] testClearBit(
            input [7:0] _A,
            input [7:0] _n
        );
        begin
            setInput(4'b1110, _A, 0, 0, _n);
            return A & ~(8'h01 << n);
        end
    endfunction

    function [7:0] testSetBit(
            input [7:0] _A,
            input [7:0] _n
        );
        begin
            setInput(4'b1111, _A, 0, 0, _n);
            return A | (8'h01 << n);
        end
    endfunction

endmodule
