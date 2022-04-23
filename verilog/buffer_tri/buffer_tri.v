module buffer_tri (
    input enable,
    input [7:0] in,
    output [7:0] out
);

    assign out = enable?in:8'bzzzz_zzzz;

endmodule