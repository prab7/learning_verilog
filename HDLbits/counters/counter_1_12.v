// I didn't end up using the fucking counter4. it's confusing as hell what they want us to do.

module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    always @(posedge clk) begin
        if(reset | ((Q == 4'd12) & enable)) Q <= 1;
        else Q <= (enable) ? Q + 1 : Q;
    end
    
    assign c_enable = enable;
    assign c_load = (reset | ((Q == 12) & enable));
    assign c_d = c_load ? 1 : 0;


endmodule
