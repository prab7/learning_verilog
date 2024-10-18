// brute force coding statemachine
// Moore machine
module pair_detector (
    input clk, in, reset,
    output reg detect
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        
        if(reset)
            state <= 2'b00;
        else begin
           case (state)
            2'b00 :
            begin
                if(in) state <= 2'b01;
                else state <= 2'b10;
            end 
            2'b01 :
            begin
                if(in) state <= 2'b11;
                else state <= 2'b10;
            end
            2'b10 :
            begin
                if(in) state <= 2'b01;
                else state <= 2'b11;
            end
            2'b11 :
            begin
                if(in) state <= 2'b01;
                else state <= 2'b10;
            end
            endcase 
        end
    end

    always @(posedge clk or posedge reset) begin
        if(reset)
            detect <= 0;
        else if(state == 2'b11)
            detect <= 1;
        else
            detect <= 0;
    end

endmodule