// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 

    assign out_assign = (sel_b1 == 1 && sel_b2 == 1) ? b : a;

    always @(*) begin

        if(sel_b1 == 1 && sel_b2 == 1)
            out_always = b;
        else out_always = a;
    end

endmodule

// if_statement latches
module top_module2 (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);

    always @(*) begin
        
        if(cpu_overheated)
            shut_off_computer = 1;
        else
            shut_off_computer = 0;
    end

    always @(*) begin
        
        if (~arrived)

    end

endmodule