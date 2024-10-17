`timescale 1ns/1ns
`include "2x4_decoder.v"

module decoder_2x4_tb;

    reg [1:0] a;
    wire [3:0] d;

    decoder_2x4 UUT(a, d);

    initial begin
        $dumpfile("decoder_2x4_tb.vcd");
        $dumpvars(0, decoder_2x4_tb);

        a = 2'b00; #20;
        a = 2'b01; #20;
        a = 2'b10; #20;
        a = 2'b11; #20;

        $display("ho gaya bc compile");
    end
    
endmodule