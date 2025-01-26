module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    decade count0 (clk, reset, 1'b1, q[3:0]);
    decade count1 (clk, reset, ena[1], q[7:4]);
    decade count2 (clk, reset, ena[2], q[11:8]);
    decade count3 (clk, reset, ena[3], q[15:12]);
    
	assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[3:0] == 4'd9) & (q[7:4] == 4'd9); 
    assign ena[3] = (q[3:0] == 4'd9) & (q[7:4] == 4'd9) & (q[11:8] == 4'd9);
    

endmodule

module decade (
	input clk,
	input reset,
    input enable,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (reset)
			q <= 0;
    	else if(enable & (q == 4'd9))
            q <= 0;
    	else if(enable)
			q <= q+1;
    	else
            q <= q;
    end
endmodule