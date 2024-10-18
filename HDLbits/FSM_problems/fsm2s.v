
///// My solution /////

module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out
);

    localparam OFF = 1'b0, ON = 1'b1;
    reg state;

    always @(posedge clk) begin 

        if(reset)
            state <= OFF;
        else begin 

            case (state)
                OFF : if(j) state <= ON;
                ON  : if(k) state <= OFF;
                default : state <= OFF;
            endcase
        end
    end

    assign out = state;


endmodule