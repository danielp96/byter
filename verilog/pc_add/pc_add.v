module pc_add (
    input enable,
    input [11:0] pc_addr,
    input [11:0] in_addr,
    output [11:0] out_addr
);

    assign out_addr = enable? in_addr + pc_addr:pc_addr;

endmodule