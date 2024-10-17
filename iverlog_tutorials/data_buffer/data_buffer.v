module data_buffer(
    input clk, last_data_packet,
    input [7:0] a, b,
    output [7:0] z, 
);

    event recieved_data;

    always @(posedge clk) begin

        if (last_data_packet)
            ->recieved_data;    
    end

    always @(recieved_data) begin
        
        // shit to be done.

    end

    
endmodule