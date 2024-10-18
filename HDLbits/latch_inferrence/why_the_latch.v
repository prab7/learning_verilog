// synthesis verilog_input_version verilog_2001
/*
Scancode [15:0]	Arrow key
16'he06b	left arrow
16'he072	down arrow
16'he074	right arrow
16'he075	up arrow
Anything else	none */

module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 

    always @(*) begin

       // up = 1'b0; down = 1'b0; left = 1'b0; right = 1'b0;

        case (scancode)
			16'he074 : {up, down, left, right} = 4'b0001;
            16'he06b : {up, down, left, right} = 4'b0010;
			16'he072 : {up, down, left, right} = 4'b0100;
			16'he075 : {up, down, left, right} = 4'b1000;
            default : {up, down, left, right} = 4'b0;
        endcase

    end

endmodule