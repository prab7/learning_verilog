// 2-to-4 Line Decoder
// 4 AND gates on the output
// 2x 1-to-2 Line Decoders (Demux).

module decoder_2x4 (
    a, d
);

    input [1:0] a;
    output [3:0] d;

    wire [3:0] w;

    decoder_1x2 U0(.a(a[0]), .d(w[3:2]));
    decoder_1x2 U1(.a(a[1]), .d(w[1:0]));

    assign d[0] = w[3] & w[1];
    assign d[1] = w[2] & w[1];
    assign d[2] = w[3] & w[0];
    assign d[3] = w[2] & w[0];

endmodule


module decoder_1x2 (
    a, d
);

    input a;
    output [1:0] d;

    assign d[0] = ~a;
    assign d[1] = a;

endmodule
