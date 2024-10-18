`timescale 1ns/1ns
`include "why_the_latch.v"

module testbench;

    reg [15:0] scancode;
    wire left, down, right, up;

    top_module UUT(scancode, left, down, right, up);

    initial begin
        $dumpfile("./scancode.vcd");
        $dumpvars(0, testbench);

        scancode = 16'h0;    #20;
        scancode = 16'h1;    #20;
        scancode = 16'he075; #20;
        scancode = 16'he06b; #20;
        scancode = 16'he06c; #20;
        scancode = 16'he072; #20;
        scancode = 16'he074; #20;
        scancode = 16'he076; #20;

        $finish;

        $display("why did i get a latch ???");

    end


endmodule
