/******       MY ATTEMPT       ******/

module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    wire [7:0] min, sec;
    reg [2:0] time_ena;

    always @(*) begin
        time_ena[0] = ena;                            // Enable for seconds
        time_ena[1] = ena & (sec == 8'h59);           // Enable for minutes
        time_ena[2] = ena & (sec == 8'h59) & (min == 8'h59); // Enable for hours
    end

    minsec seconds_module (
        .clk(clk),
        .reset(reset),
        .enable(time_ena[0]),
        .ms(sec)
    );

    minsec minutes_module (
        .clk(clk),
        .reset(reset),
        .enable(time_ena[1]),
        .ms(min)
    );

    assign ss = sec;
    assign mm = min;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh <= 8'h12; // Start at 12:00
            pm <= 0;     // Start in AM
        end else if (time_ena[2]) begin
            // Increment hours when minutes and seconds roll over
            if (hh == 8'h12) begin
                hh <= 8'h01; // Wrap around to 1
                pm <= ~pm;   // Toggle AM/PM
            end else if (hh == 8'h11) begin
                hh[3:0] <= hh[3:0] + 1'h1; // Increment the hour
                pm <= ~pm;   // Toggle AM/PM at 11 to 12 transition
            end else begin
                if (hh[3:0] == 4'h9) begin
                    hh[3:0] <= 4'h0; // Reset lower nibble
                    hh[7:4] <= hh[7:4] + 1'h1; // Increment upper nibble
                end else begin
                    hh[3:0] <= hh[3:0] + 1'h1; // Normal increment
                end
            end
        end
    end

endmodule

module minsec(
    input clk,
    input reset,
    input enable,
    output reg [7:0] ms
);
    wire en;

    assign en = (ms[3:0] == 4'd9); // Carry from lower nibble to upper nibble

    bcdcounter #(
        .MOD(4'd6),
        .start(4'b0)
    ) mod_6 (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .q(ms[7:4]) // Upper nibble (tens place)
    );

    bcdcounter #(
        .MOD(4'd10),
        .start(4'b0)
    ) mod_10 (
        .clk(clk),
        .reset(reset),
        .enable(en),
        .q(ms[3:0]) // Lower nibble (ones place)
    );

endmodule

module bcdcounter #(
    parameter MOD = 4'd10,
    parameter start = 4'b0
)(
    input clk,
    input reset,
    input enable,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= start; // Reset to the starting value
        end else if (enable) begin
            if (q == MOD - 1) begin
                q <= 0; // Wrap around at MOD value
            end else begin
                q <= q + 1; // Increment counter
            end
        end
    end
endmodule

/**********************************************/

/*****       CORRECT SOLUTION       **********/
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    reg [2:0] ena_hms;	//determine when will "ss","mm" and "hh" need to be increased
    assign ena_hms = {(ena && (mm == 8'h59) && (ss == 8'h59)), (ena && (ss == 8'h59)), ena};   
    
    count60 count_ss(
        .clk(clk),
        .reset(reset),
        .ena(ena_hms[0]),
        .q(ss)
    );
    count60 count_mm(
        .clk(clk),
        .reset(reset),
        .ena(ena_hms[1]),
        .q(mm)
    );
    
    always @(posedge clk) begin
        if(reset) begin
        	hh <= 8'h12;    //hh=12
            pm <= 0;
        end
        else begin
            if(ena_hms[2] && (mm == 8'h59) && (ss == 8'h59)) begin    //if mm=59 and ss=59
                if(hh == 8'h12)  hh <= 8'h1; //hh changes:12AM->1AM or 12PM->1PM  
            	else if(hh == 8'h11) begin  //if hh=11, PM->AM or AM->PM
            		hh[3:0] <= hh[3:0] + 1'h1; //hh=12
               		pm <= ~pm;
                end 
                else begin
                    if(hh[3:0] == 4'h9) begin
                        hh[3:0] <= 4'h0;
                        hh[7:4] <= hh[7:4] + 1'h1;
                    end
                    else hh[3:0] = hh[3:0] + 1'h1;
                end
            end
            else hh <= hh;
        end
    end

endmodule

module count60(
	input clk,
    input reset,
    input ena,
    output [7:0] q
);
    always @(posedge clk) begin
        if(reset) q <= 8'h0;
        else begin
            if(ena) begin 
                if(q[3:0] == 4'h9) begin
                    if(q[7:4] == 4'h5) q <= 8'h0;
                    else begin
                        q[7:4] <= q[7:4] + 1'h1;
                        q[3:0] <= 4'h0;
                    end 
                end
                else q[3:0] <= q[3:0] + 1'h1; 
            end
            else q <= q;
        end
    end
endmodule
/**********************************************/