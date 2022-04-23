module byter (
    input clk,
    input reset,
    input [7:0]  in_port_00, in_port_01, in_port_02, in_port_03, in_port_04, in_port_05, in_port_06, in_port_07, in_port_08, in_port_09, in_port_10, in_port_11, in_port_12, in_port_13, in_port_14, in_port_15,
    output c_flag, z_flag,
    output [7:0] A, B, instr, oprnd, data_bus, out_port_00, out_port_01, out_port_02, out_port_03, out_port_04, out_port_05, out_port_06, out_port_07, out_port_08, out_port_09, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15,
    output [15:0] program,
    output [11:0] pc, pc_load, address
);
    
    wire loadFlags, loadPC, incPC, csRam, weRam, regEn, litEn, memEn, csStackReg, weStackReg, csStackAddr, weStackAddr, outEnable, inEnable, eAluB, eAluY, csPCadd;
    wire C_alu, Z_alu, C, Z;
    wire [3:0] S;
    wire [15:0] _program;
    wire [11:0] _program_counter, _address, _pc_load, _pcadd, _pc_stack, _pcadd_data;
    wire [7:0] _instr, _oprnd, regA, regB, _data_bus, _alu, _rstack_data;

    assign c_flag = C;
    assign z_flag = Z;
    assign A = regA;
    assign B = regB;
    assign instr = _instr;
    assign oprnd = _oprnd;
    assign data_bus = _data_bus;
    assign program = _program;
    assign pc = _program_counter;
    assign pc_load = _pc_load;
    assign address = _address;

    assign _address = {_instr[3:0], _oprnd};

    flags F(clk, loadFlags, reset, C_alu, Z_alu, C, Z);
    decoder DEC(_instr, C, Z, S, loadFlags, loadPC, incPC, csRam, weRam, regEn, litEn, memEn, csStackReg, weStackReg, csStackAddr, weStackAddr, outEnable, inEnable, eAluB, eAluY, csPCadd);

    program_counter PC(clk, incPC, reset, loadPC, _pc_load, _program_counter);
    rom ROM(_program_counter, _program);
    fetch FETCH(~clk, 1'b1, reset, _program, {_instr, _oprnd});
    ram RAM(csRam, weRam, _address, _data_bus);

    pc_add PC_ADD( csPCadd, _program_counter, _pcadd_data, _pcadd);
    stack PC_STACK(clk, reset, csStackAddr, weStackAddr, _pcadd+12'h001, _pc_stack);

    assign _pc_load = ((csStackAddr && ~weStackAddr) || csPCadd)? (csPCadd? _pcadd: _pc_stack) :_address;

    reg_module REG(clk, reset, regEn, litEn, memEn, _oprnd[7:4], _oprnd[3:0], _alu, _oprnd, regA, regB, _pcadd_data);
    alu ALU(regA, eAluB?_data_bus:regB, S, _oprnd[2:0], C, _alu, C_alu, Z_alu);
    stack REG_STACK(clk, reset, csStackReg, weStackReg, { 4'h0, _data_bus}, _rstack_data);

    buffer_tri RSTACK_DATA(csStackReg && ~weStackReg, _rstack_data, _data_bus);

    buffer_tri ALU_DATA(eAluY, _alu, _data_bus);

    in_module IN_PORT(inEnable, _oprnd[3:0], in_port_00, in_port_01, in_port_02, in_port_03, in_port_04, in_port_05, in_port_06, in_port_07, in_port_08, in_port_09, in_port_10, in_port_11, in_port_12, in_port_13, in_port_14, in_port_15, _data_bus);
    out_module OUT_PORT(clk, reset, outEnable, _oprnd[7:4], _data_bus, out_port_00, out_port_01, out_port_02, out_port_03, out_port_04, out_port_05, out_port_06, out_port_07, out_port_08, out_port_09, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15);

endmodule