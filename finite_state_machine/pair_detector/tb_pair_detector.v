`timescale 10ns/100ps
`include "pair_detector.v"

module tb_pair_detector;

reg [4:0] d;
reg clk;
reg rst;
reg in;
wire detect;

pair_detector UUT(.clk(clk), .in(in), .reset(rst), .detect(detect));

always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    in  = 0;
end

initial begin
    $dumpfile("tb_pair_detector.vcd");
    $dumpvars(0, tb_pair_detector);

    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 1;
    #20 in = 0;
    #20 in = 0;
    #20 in = 0;
    #20 in = 1;
    $finish;
    
end

endmodule