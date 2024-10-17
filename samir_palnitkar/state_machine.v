`define TRUE 1'b1;
`define FALSE 1'b0;
`define RED    2'd0;
`define YELLOW 2'd1;
`define GREEN  2'd2;

// state definition  HWY    CNTRY
`define s0 3'd0    // Green     Red
`define s1 3'd1    // Yellow    Red
`define s2 3'd2    // Red       Red
`define s3 3'd3    // Red       Green
`define s4 3'd4    // Red       Yellow

// delays 
`define Y2RDELAY 3
`define R2GDELAY 2

module sig_control (
    output reg [1:0] hwy, cntry,
    input x, clk, clr
);

    reg [2:0] state;
    reg [2:0] next_state;

    initial begin 
        state = `s0;
        next_state = `s0;
        hwy = `GREEN;
        cntry = `RED;
    end

    always @(posedge clk) begin 
        state = next_state;
    end 

    always @(state) begin 
        case(state)
            `s0: begin 
                hwy = `GREEN;
                cntry = `RED;
            end
            `s1: begin 
                hwy = `YELLOW;
                cntry = `RED;
            end
            `s2: begin 
                hwy = `RED;
                cntry = `RED;
            end
            `s3: begin 
                hwy = `RED;
                cntry = `GREEN;
            end
            `s4: begin 
                hwy = `RED;
                cntry = `YELLOW;
            end
        endcase
    end

    always @(state or clr or x) begin 
        if(clr)
            next_state = `s0;
        else begin 
            case(state)
            `s0: if(x)
                    next_state = `s1;
                 else
                    next_state = `s0; 
            `s1: begin 
                repeat(`Y2RDELAY) @(posedge clk);
                next_state = `s2;
            end
            `s2: begin 
                repeat(`R2GDELAY) @(posedge clk);
                next_state = `s3;
            end
            `s3: if(x)
                    next_state = `s3;
                 else
                    next_state = `s4;
            `s2: begin 
                repeat(`Y2RDELAY) @(posedge clk);
                next_state = `s0;
            end
            default : next_state = `s0;
        endcase
        end
    end

endmodule
