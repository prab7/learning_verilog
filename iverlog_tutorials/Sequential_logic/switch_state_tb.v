`timescale 1ns/1ns
`include "switch_state.v"

module switch_state_tb;

    reg a, b, clk = 0;
    wire z;

    top UUT(a, b, clk, z);
    
    always begin
        clk = ~clk; // toggle clock
        #10;
    end

    initial begin
        $dumpfile("./switch_state_tb.vcd");
        $dumpvars(0, switch_state_tb);

        {a, b} = 2'b00; #20;
        {a, b} = 2'b11; #20;
        {a, b} = 2'b01; #20;
        {a, b} = 2'b00; #20;
        {a, b} = 2'b11; #20;
        {a, b} = 2'b10; #20;
        {a, b} = 2'b01; #20;
        {a, b} = 2'b10; #20;
        $finish;
    end

endmodule