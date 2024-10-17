`timescale 1ns/1ns
`include "2x4_decoder.v"

module decoder_1x2_tb;

    reg a;
    wire [1:0] d;

    decoder_1x2 UUT(a, d);

    initial begin
        $dumpfile("./decoder_1x2_tb.vcd");
        $dumpvars(0, decoder_1x2_tb);

        a = 0; #20;
        a = 1; #20;

        $display("end of test.");
    end

endmodule