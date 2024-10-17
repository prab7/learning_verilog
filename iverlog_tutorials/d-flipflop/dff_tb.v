`timescale 1ns / 1ps
`include "dff.v"

module tb_dff_with_or;

    // Inputs to the circuit
    reg clk = 0;
    reg in;
    
    // Output from the circuit
    wire out;
    
    // Instantiate the design under test (DUT)
    dff dut (
        .clk(clk),
        .in(in),
        .out(out)
    );

    // Generate a clock signal (50% duty cycle)

    always begin
        #5 clk = ~clk;
    end

    // Stimulus block
    initial begin
        $dumpfile("./dff.vcd");
        $dumpvars(0, tb_dff_with_or);

        // Initialize the inputs
        in = 0;
        
        // Apply test vectors
        #10 in = 1; // Set 'in' to 1 after 10 time units
        #10 in = 0; // Set 'in' to 0 after 10 more time units
        #10 in = 1; // Set 'in' to 1 again
        #20 in = 0; // Keep 'in' low for a longer period
        
        // End the simulation after some time
        #50 $finish;
    end
    
    // Monitor output
    initial begin
        $monitor("Time = %0t, clk = %b, in = %b, out = %b", $time, clk, in, out);
    end

endmodule