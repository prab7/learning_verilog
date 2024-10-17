`timescale 1ns/1ns
`include "d_flipflop.v"

module testbench;

    reg d = 0, clk = 0;
    wire q;

    flipflop UUT(d, clk, q);

    always begin
        clk = ~clk;
        #10;
    end

    initial begin
        $dumpfile("./flipflop.vcd");
        $dumpvars(0, testbench);

        d = 0; #45;
        d = 1; #45;
        d = 0; #45;
        $finish;
    end
endmodule