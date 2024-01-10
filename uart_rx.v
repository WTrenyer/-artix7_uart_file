module uart_rx(
    input   clk,rst_n,
    input   rx,
    output  [7:0]rx_data_out,
    output  sign
);

    //9600bps   4nsÃ¿¸öÍ£Ö¹???

parameter clk_bps = 50_000_000;
parameter clk_en  = (clk_bps*10)/9600;



reg bps_start;
reg bit_start;
reg en_bpss;
integer cnt_bps;
integer cnt_bit;
reg half;
always @(posedge clk or negedge rx_en) begin
    if(!rx_en) begin
        cnt_bps <= 0;
        bps_start <= 0;
        half<=0;
    end else if(cnt_bps == (clk_en/20)) begin
        half <= 1;
        cnt_bps <= 0;
    end else if(num_bit == 8 )begin
        half <= 0;
    end else begin

        cnt_bps <= cnt_bps + 1;
    end
end

always @(posedge clk or negedge half) begin
    if(!half) begin
        en_bpss<=0;
        bit_start <= 0;
        cnt_bit<=0;
    end else if(cnt_bit == (clk_en/10) + 1) begin
        bit_start <= 1;
        cnt_bit <= 0;
    end else begin
        bit_start <= 0;
        cnt_bit <= cnt_bit + 1;
    end
end


reg rx_reg0,rx_reg1;
always @(posedge clk) begin
    rx_reg0<=rx;
    rx_reg1<=rx_reg0;
end


reg rx_en;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        rx_en<=0;
    end else if(!rx&rx_reg0)begin
        rx_en<=1;
    end else    if(num_bit == 8 )
        rx_en<=0;

end


integer num_bit;
reg [7:0] rx_data;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        num_bit <= 0;
        rx_data<=0;
    end else if(rx_en) begin
        if(bit_start) begin
            case (num_bit)
                0: rx_data[0] <= rx;
                1: rx_data[1] <= rx;
                2: rx_data[2] <= rx;
                3: rx_data[3] <= rx;
                4: rx_data[4] <= rx;
                5: rx_data[5] <= rx;
                6: rx_data[6] <= rx;
                7: rx_data[7] <= rx;

            endcase
            num_bit <= num_bit + 1;
        end
    end else
        num_bit <= 0;
end
assign rx_data_out = rx_data;

endmodule