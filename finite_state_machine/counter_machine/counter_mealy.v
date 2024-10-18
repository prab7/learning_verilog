// Mealy machine
// count at go = 1, flag DONE when done counting
// counter until 16

module counter_mod (
    input clk, rst_btn, go_btn,
    output reg [3:0] led,
    output reg       done_sig 
);

    // States
    localparam STATE_IDLE     = 1'd0;
    localparam STATE_COUNTING = 1'd1;

    // Max counts for clock divider and counter
    localparam MAX_CLK_COUNT = 24'd1500000 - 1; // for 0.25 second time period
    localparam MAX_LED       = 4'hf;

    // Active-high Internal signals, inverting rst_btn, go_btn, presses
    wire rst = ~rst_btn;
    wire go = ~go_btn;

    // internal storage elements
    reg        div_clk;
    reg [1:0]  state;
    reg [23:0] clk_count;

    // Clock divider
    always @(posedge clk or posedge rst) begin 

        if(rst == 1'b1) begin 
            clk_count <= 24'b0;
            div_clk <= 1'b0;
        end
        else if (clk_count == MAX_CLK_COUNT) begin
            clk_count <= 24'b0;
            div_clk <= ~div_clk;
        end
        else begin
            clk_count <= clk_count + 1; 
        end

    end

    // state machine
    always @(posedge div_clk or posedge rst) begin 

        if(rst == 1'b1) begin 
            state <= STATE_IDLE;
        end
        else begin 

            case(state)
                STATE_IDLE : begin 
                    done_sig <= 1'b0;
                    if(go == 1'b1) begin 
                        state <= STATE_COUNTING;
                    end
                end

                STATE_COUNTING : begin
                    if (led == MAX_LED) begin 
                        done_sig <= 1'b1;
                        state <= STATE_IDLE;
                    end
                end

                default : state <= STATE_IDLE;

            endcase
        end

    end

    // Handle LED counter
    always @(posedge clk or posedge rst) begin 

        if(rst == 1'b1) begin 
            led <= 4'd0;

        end else begin 
            if(state == STATE_COUNTING) begin 
                led <= led + 1;
            end else begin
                led <= 4'd0;
            end
        end
    end

endmodule
