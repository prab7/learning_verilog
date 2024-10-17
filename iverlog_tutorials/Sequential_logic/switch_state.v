module top(a, b, clk, z);

    input a, b, clk;
    output z;
    
    // reg is a collection of flipflops
    // single bit reg would just be one flipflop
    reg d = 0;

    assign z = d;

    // state machine
    always @(posedge clk) begin
        d = a ^ b ^ d;
    end

endmodule   