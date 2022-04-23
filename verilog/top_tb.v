module testbench();
    reg clk = 1;
    reg reset;
    reg [7:0]  in_port_00, in_port_01, in_port_02, in_port_03, in_port_04, in_port_05, in_port_06, in_port_07, in_port_08, in_port_09, in_port_10, in_port_11, in_port_12, in_port_13, in_port_14, in_port_15;
    wire c_flag, z_flag;
    wire [7:0] A, B, instr, oprnd, data_bus, out_port_00, out_port_01, out_port_02, out_port_03, out_port_04, out_port_05, out_port_06, out_port_07, out_port_08, out_port_09, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15;
    wire [15:0] program;
    wire [11:0] pc, pc_load, address;

    byter BYTER(clk, reset,
                in_port_00, in_port_01, in_port_02, in_port_03, in_port_04, in_port_05, in_port_06, in_port_07, in_port_08, in_port_09, in_port_10, in_port_11, in_port_12, in_port_13, in_port_14, in_port_15,
                c_flag, z_flag,
                A, B, instr, oprnd, data_bus,
                out_port_00, out_port_01, out_port_02, out_port_03, out_port_04, out_port_05, out_port_06, out_port_07, out_port_08, out_port_09, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15,
                program, pc, pc_load, address
                );

    initial begin
        reset=0; in_port_00=8'h11; in_port_01=8'h44; in_port_02=8'haa; in_port_03=8'hff;
        #1 reset=1;
        #1 reset=0;
        #300 $finish;
    end


    always
    begin
        #5 clk=~clk;
    end

    initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, testbench);
  end


endmodule