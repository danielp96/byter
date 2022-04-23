module top();

    reg enable;
    reg write_enable;
    reg [11:0] addr;
    reg [3:0] data;
    wire [3:0] data_bus;

    ram RAM(enable, write_enable, addr, data_bus);

    assign data_bus = ~(enable & ~write_enable)?data:4'bzzzz;

    initial begin
        enable=0; write_enable=0; addr=0; data=1;

        $display("enable\twrite_enable\taddr\t\tdata\data_bus");
        $monitor("%b\t%b\t\t%b\t%b\t%b", enable, write_enable, addr, data, data_bus);

        #1 enable=1; write_enable=0; addr=0; data=1;
        #2 enable=1; write_enable=0; addr=2; data=2;
        #2 enable=1; write_enable=1; addr=2; data=2;
        #2 enable=1; write_enable=0; addr=2; data=0;

        $finish;
    end


endmodule
