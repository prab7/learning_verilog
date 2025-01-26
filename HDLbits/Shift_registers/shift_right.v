module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    
    always @(posedge clk or posedge areset) begin 
        if(areset)
            q <= 4'b0000;
        else if(load)  // load priority.
            q <= data;
        else if(ena)
            q <= q >> 1; // or q <= q[3:1];
        else q <= q;
    end

endmodule