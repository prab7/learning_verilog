
///// My solution: JK flip flop /////

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output reg out);
    
    always @(posedge clk or posedge areset) begin 
        if(areset)
            out <= 1'b0;
        else
            out <= ((~out)&j | out&(~k));    
    end
endmodule


///// My solution: state_machine /////

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output reg out
);

    localparam OFF = 1'b0, ON = 1'b1;
    reg state;

    always @(posedge clk or posedge areset) begin 

        if(areset)
            state <= OFF;
        else begin 

            case (state)
                OFF : if(j) state <= ON;
                ON  : if(k) state <= OFF;
                default : state <= OFF;
            endcase
        end
    end

    always @(*) out = state;

    
endmodule


/**** Model Solution *****/

module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	parameter A=0, B=1;
	reg state;
	reg next;
    
    always_comb begin
		case (state)
			A: next = j ? B : A;
			B: next = k ? A : B;
		endcase
    end
    
    always @(posedge clk, posedge areset) begin
		if (areset) state <= A;
        else state <= next;
	end
		
	assign out = (state==B);

	
endmodule