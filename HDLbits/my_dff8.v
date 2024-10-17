module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] w0, w1, w2, w3;
    
    my_dff8 u0(clk, d, w1);
    my_dff8 u1(clk, w1, w2);
    my_dff8 u2(clk, w2, w3);
    
    assign q = sel[1] ? (sel[0] ? w3 : w2) : (sel[0] ? w1 : w0);

endmodule

module my_dff8 (clk, d, q);

    input clk;
    input  [7:0] d;
    output reg [7:0] q;

    always @(posedge clk) begin
        q = d;
    end

endmodule