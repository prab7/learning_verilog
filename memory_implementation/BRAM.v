// Block RAM
/* when might it be used ?
- Storing large Look-up Tables (e.g. celsius to Fahrenheit conversion)
    - different from individual LUTs built into an FPGA
- Storing Read-Only Data
- Storing data read-off external device (e.g. Calibration params)
- Creating a FIFO to store temporary data (e.g. flash, ADC)
- Crossing clock domains using a FIFO 
- in general, storing large amounts of data */

// Block RAM
// Discrete part of an FPGA, limited available
// Storage of "large" amounts of data
// width and depth

// Verilog implementation for iCE40 FPGA devices
module ram (din, addr, write_en, clk, dout);
    parameter addr_width = 9;
    parameter data_width = 8;
    input [addr_width-1:0] addr;
    input [data_width-1:0] din;
    input write_en, clk;
    output reg [data_width-1:0] dout;
    reg [data_width-1:0] mem [(1<<addr_width)-1:0];

    always @(posedge clk) begin 
        if(write_en)
            mem[(addr)] <= din;
        else
            dout = mem[addr]; 
    end
endmodule



