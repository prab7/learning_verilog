
///// My solution: Mealy Machine /////

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
    parameter
    	ABOVE_S3      = 2'b11,
        BETWEEN_S3_S2 = 2'b10,
        BETWEEN_S2_S1 = 2'b01,
        BELOW_S1 	  = 2'b00;
    
    reg [1:0] state;
    
    always @(posedge clk) begin 
        
        if(reset) begin 
            state <= BELOW_S1;
            dfr <= 1'b1;
        end 
        else begin 

            case (state)
                BELOW_S1 : begin
                     if(s[1]) begin
                        state <= BETWEEN_S2_S1;
                        dfr <= 0;
                    end
                end

                BETWEEN_S2_S1 :begin
                    if(s[2]) begin
                        state <= BETWEEN_S3_S2;
                        dfr <= 0;
                    end else if (!s[1]) begin
                        state <= BELOW_S1;
                        dfr <= 1;
                    end 
                end

                BETWEEN_S3_S2 : begin
                    if(s[3]) begin
                        state <= ABOVE_S3;
                        dfr <= 0;
                    end else if (!s[2]) begin  
                        state <= BETWEEN_S2_S1;
                        dfr <= 1;
                    end 
                end
                ABOVE_S3 : begin
                    if(!s[3]) begin 
                        state <= BETWEEN_S3_S2; 
                        dfr <= 1;
                    end
                end
                default state = 'x;
            endcase 
        end
    end

    always @(*) begin 
        if(state == BELOW_S1) begin 
            {fr1, fr2, fr3} = 3'b111;
        end else if (state == BETWEEN_S2_S1) begin
            {fr1, fr2, fr3} = 3'b110;
        end else if (state == BETWEEN_S3_S2) begin
            {fr1, fr2, fr3} = 3'b100;
        end else begin
            {fr1, fr2, fr3} = 3'b000;
        end
    end


endmodule



/**** Model Solution: Moore Machine *****/

module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);


	// Give state names and assignments. I'm lazy, so I like to use decimal numbers.
	// It doesn't really matter what assignment is used, as long as they're unique.
	// We have 6 states here.
	parameter A2=0, B1=1, B2=2, C1=3, C2=4, D1=5;
	reg [2:0] state, next;		// Make sure these are big enough to hold the state encodings.
	


    // Edge-triggered always block (DFFs) for state flip-flops. Synchronous reset.	
	always @(posedge clk) begin
		if (reset) state <= A2;
		else state <= next;
	end



    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.    
	always@(*) begin
		case (state)
			A2: next = s[1] ? B1 : A2;
			B1: next = s[2] ? C1 : (s[1] ? B1 : A2);
			B2: next = s[2] ? C1 : (s[1] ? B2 : A2);
			C1: next = s[3] ? D1 : (s[2] ? C1 : B2);
			C2: next = s[3] ? D1 : (s[2] ? C2 : B2);
			D1: next = s[3] ? D1 : C2;
			default: next = 'x;
		endcase
	end
	
	
	
	// Combinational output logic. In this problem, a procedural block (combinational always block) 
	// is more convenient. Be careful not to create a latch.
	always@(*) begin
		case (state)
			A2: {fr3, fr2, fr1, dfr} = 4'b1111;
			B1: {fr3, fr2, fr1, dfr} = 4'b0110;
			B2: {fr3, fr2, fr1, dfr} = 4'b0111;
			C1: {fr3, fr2, fr1, dfr} = 4'b0010;
			C2: {fr3, fr2, fr1, dfr} = 4'b0011;
			D1: {fr3, fr2, fr1, dfr} = 4'b0000;
			default: {fr3, fr2, fr1, dfr} = 'x;
		endcase
	end
	
endmodule
