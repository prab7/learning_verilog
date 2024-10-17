module concat (    
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z
);
    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};

endmodule

module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    
    assign out = ~{ 5{a, b, c, d, e} } ^ {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};

endmodule