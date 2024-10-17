`timescale 1ns/ 1ns
`include "greater_than.v"

module greater_than_tb;

    reg [1:0] a, b;
    wire f;

    greater_than uut (a, b, f);

    initial begin

        $dumpfile("./greater_than_tb.vcd");
        $dumpvars(0, greater_than_tb);

        {a, b} = 4'd0; #20;
        {a, b} = 4'd1; #20;
        {a, b} = 4'd2; #20;
        {a, b} = 4'd3; #20;
        {a, b} = 4'd4; #20;
        {a, b} = 4'd5; #20;
        {a, b} = 4'd6; #20;
        {a, b} = 4'd7; #20;
        {a, b} = 4'd8; #20;
        {a, b} = 4'd9; #20;
        {a, b} = 4'd10; #20;
        {a, b} = 4'd11; #20;
        {a, b} = 4'd12; #20;
        {a, b} = 4'd13; #20;
        {a, b} = 4'd14; #20;
        {a, b} = 4'd15; #20;

        $display("Test is complete.");
    end

endmodule