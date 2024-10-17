`timescale 1ns/1ns
`include "my_dff8.v"

module my_dff8_tb;

    reg [7:0] d = 8'b0;
    reg clk = 0;
    wire [7:0] q;

    my_dff8 UUT(clk, d, q);

    always begin
        clk = ~clk;
        #10;
    end

    initial begin
        $dumpfile("./my_dff8_tb.vcd");
        $dumpvars(0, my_dff8_tb);

        d = 8'd0; #45;
        d = 8'd2; #45;
        d = 8'd3; #45;
        d = 8'd1; #45;
        d = 8'd4; #45;
        d = 8'd5; #45;
        d = 8'd6; #45;
        d = 8'd7; #45;
        $finish;

    end

endmodule