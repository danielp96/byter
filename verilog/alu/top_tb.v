module testbench ();
    reg [7:0] A, B;
    reg [3:0] S;
    reg [2:0] n;
    reg C_in;
    wire [7:0] Y;
    wire C, Z;

    alu Alu(A, B, S, n, C_in, Y, C, Z);

    initial begin
        S=4'b0000; A=8'b0000_0000; B=8'b0000_0000; C_in=0; n=3'b000;
        $display("\nS\tA\t\tB\t\tC_in\tn\tY\t\tC\tZ");
        $monitor("%b\t%b\t%b\t%b\t%d\t%b\t%b\t%b\t", S, A, B, C_in, n, Y, C, Z);

        // logic operations
        #1 S=4'b0000; A=8'b0000_0010; B=8'b0000_0001; C_in=0; n=3'b000;
        #1 S=4'b0001; A=8'b0000_0011; B=8'b0000_0110; C_in=0; n=3'b000;
        #1 S=4'b0010; A=8'b0000_0011; B=8'b0000_0110; C_in=0; n=3'b000;
        #1 S=4'b0011; A=8'b1111_1111; B=8'b0000_0000; C_in=0; n=3'b000;
        #1 S=4'b0100; A=8'b1111_1111; B=8'b0101_1010; C_in=0; n=3'b000;

        // add
        #1 S=4'b0101; A=8'b0000_1111; B=8'b0110_0001; C_in=0; n=3'b000;
        #1 S=4'b0101; A=8'b0000_1111; B=8'b1111_0001; C_in=0; n=3'b000;

        // sub
        #1 S=4'b0110; A=8'b0000_1000; B=8'b0000_0001; C_in=0; n=3'b000;
        #1 S=4'b0110; A=8'b0000_0000; B=8'b0000_0001; C_in=0; n=3'b000;
        #1 S=4'b0110; A=8'b0000_0001; B=8'b0000_0001; C_in=0; n=3'b000;

        // swap nibbles
        #1 S=4'b0111; A=8'b1001_0110; B=8'b1111_0000; C_in=0; n=3'b000;

        // left shift, no carry
        #1 S=4'b1000; A=8'b1001_0110; B=8'b1000_1111; C_in=0; n=3'b000;

        // left shift, carry
        #1 S=4'b1001; A=8'b1001_0110; B=8'b1000_1111; C_in=0; n=3'b000;
        #1 S=4'b1001; A=8'b1001_0110; B=8'b0000_1111; C_in=1; n=3'b000;

        // right shift, no carry
        #1 S=4'b1010; A=8'b1001_0110; B=8'b1111_0001; C_in=0; n=3'b000;

        // right shift, carry
        #1 S=4'b1011; A=8'b1001_0110; B=8'b1111_0001; C_in=0; n=3'b000;
        #1 S=4'b1011; A=8'b1001_0110; B=8'b1111_0000; C_in=1; n=3'b000;

        // increase B
        #1 S=4'b1100; A=8'b1001_0110; B=8'b0000_0011; C_in=1; n=3'b000;
        #1 S=4'b1100; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b000;

        // decrease B
        #1 S=4'b1101; A=8'b1001_0110; B=8'b0000_0011; C_in=1; n=3'b000;
        #1 S=4'b1101; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b000;

        // clear n bit of B
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b000;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b001;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b010;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b011;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b100;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b101;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b110;
        #1 S=4'b1110; A=8'b1001_0110; B=8'b1111_1111; C_in=1; n=3'b111;

        // set n bit of B
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b000;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b001;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b010;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b011;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b100;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b101;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b110;
        #1 S=4'b1111; A=8'b1001_0110; B=8'b0000_0000; C_in=1; n=3'b111;

        #2 $finish();
    end


endmodule