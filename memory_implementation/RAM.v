module single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input rw,
    input clk,
    output [7:0] q
);

    reg [7:0] ram [64:0]; // 64 byte ram
    reg [5:0] addr_reg; // address register

    always @(posedge clk) begin 
        if(rw)
            ram[addr] <= data;
        else
            addr_reg <= addr;
    end

    assign q = ram[addr_reg];

endmodule


module dual_port_ram (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input rw_a, rw_b,
    input clk,
    output reg [7:0] q_a, q_b
);

    reg [7:0] ram [64:0]; // 64 byte ram

    always @(posedge clk) begin 
        if(rw_a)
            ram[addr_a] <= data_a;
        else
            q_a <= ram[addr_a];
    end

    always @(posedge clk) begin 
        if(rw_b)
            ram[addr_b] <= data_b;
        else
            q_b <= ram[addr_b];
    end

endmodule

