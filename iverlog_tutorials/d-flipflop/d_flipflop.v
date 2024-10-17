module flipflop (d, clk, q);

    input d, clk;
    output reg q;

    always @(posedge clk) begin
        q = d;
    end

endmodule