
///// My solution: state_machine /////

module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state, next_state;
    always_comb begin 
        case(state)
            A : if(in) next_state = B; else next_state =  A;
            B : if(in) next_state = B; else next_state =  C;
            C : if(in) next_state = D; else next_state =  A;
            D : if(in) next_state = B; else next_state =  C;
            default : next_state = A;
        endcase
    end

    always @(posedge clk or posedge areset) begin 
        if(areset)
            state <= A;
        else begin 
        	state = next_state;
        end
    end
    assign out = (state == D);

endmodule


/**** Model Solution *****/

module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Give state names and assignments. I'm lazy, so I like to use decimal numbers.
	// It doesn't really matter what assignment is used, as long as they're unique.
	parameter A=0, B=1, C=2, D=3;
	reg [1:0] state;		// Make sure state and next are big enough to hold the state encodings.
	reg [1:0] next;
    



    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.    
    always@(*) begin
		case (state)
			A: next = in ? B : A;
			B: next = in ? B : C;
			C: next = in ? D : A;
			D: next = in ? B : C;
		endcase
    end



    // Edge-triggered always block (DFFs) for state flip-flops. Asynchronous reset.
    always @(posedge clk, posedge areset) begin
		if (areset) state <= A;
        else state <= next;
	end
		

		
	// Combinational output logic. In this problem, an assign statement is the simplest.		
	assign out = (state==D);
	
endmodule