`timescale 1ns/1ps
`include "state_machine.v"

module stimulus;
wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD;
 //if TRUE, indicates that there is car on
 //the country road
reg CLOCK, CLEAR;
//Instantiate signal controller
sig_control SC(MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);
//Set up monitor
initial
    $monitor($time, " Main Sig = %b Country Sig = %b Car_on_cntry = %b",
    MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);
//Set up clock
initial
begin
    CLOCK = `FALSE;
    forever #5 CLOCK = ~CLOCK;
end
//control clear signal
initial 
begin
    CLEAR = `TRUE;
    repeat (5) @(negedge CLOCK);
    CLEAR = `FALSE;
end
//apply stimulus
initial
begin
    CAR_ON_CNTRY_RD = `FALSE;
    repeat(20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
    repeat(10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
    repeat(20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
    repeat(10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
    repeat(20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
    repeat(10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
    repeat(10)@(negedge CLOCK); $finish;    
end
endmodule 