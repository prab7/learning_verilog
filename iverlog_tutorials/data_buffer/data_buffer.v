module data_buffer(
    input clk, last_data_packet,
    input [7:0] data_pkt,
    output [7:0] data_buf, 
);

    event recieved_data;

    always @(posedge clk) begin

        if (last_data_packet)
            ->recieved_data;    
    end

    always @(recieved_data) begin
        data_buf = {data_pkt[0], data_pkt[1], data_pkt[2], data_pkt[3]};
    end
    
endmodule
