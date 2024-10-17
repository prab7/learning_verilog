module fulladd (
    sum, c_out, a, b, c_in
);

    output sum, c_out;
    input a, b, c_in;

    wire s1, c1, c2;

    xor (s1, a, b);
    and (c1, a, b);

    xor (sum, s1, c_in);
    and (c2, s1, c_in);

    or (c_out, c2, c1);
    
endmodule

module gate_lvl_full_adder (
    sum, c_out, a, b, c_in
);
    output [3:0] sum;
    output c_out;
    input [3:0] a, b;
    input c_in;

    wire c1, c2, c3;

    // instantiating 1-bit full adders
    fulladd fa0  (sum[0], c1, a[0], b[0], c_in);
    fulladd fa0 (sum[1], c2, a[1], b[1], c2);
    fulladd fa0 (sum[2], c3, a[2], b[2], c0);
    fulladd fa0 (sum[3], c_out, a[3], b[3], c1);
    
endmodule