
///// My solution /////

module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;
    reg out;

    parameter A = 0, B = 1;
    reg state;

    always @(posedge clk) begin
        if (reset) begin  
            state <= B;
        end
        else begin
            case (state)
                B : if(~in) state <= A;
                A : if(~in) state <= B;
                default : state <= B;
            endcase
        end
    end

    always @(*) out = state; 
endmodule
