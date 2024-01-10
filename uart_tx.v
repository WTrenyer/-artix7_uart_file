module uart_tx(
    input   clk,rst_n,
    output   tx,
    input[7:0]tx_data,
    input   en
);

    //9600bps   4ns???????
parameter clk_bps = 50_000_000;
parameter clk_en  = (clk_bps*10)/9600;



reg bps_start;
reg bit_start;
integer cnt_bps;
integer cnt_bit;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt_bps<=0;
        cnt_bit<=0;
        bps_start<=0;
    end else if(cnt_bps == clk_en+2)begin
        bps_start<=1;
        cnt_bps <=0;
    end else if(cnt_bit == clk_en/10)begin
        bit_start<=1;
        cnt_bit<=0;
    end else begin
        bps_start<=0;
        bit_start<=0;
        cnt_bps<=cnt_bps+1;
        cnt_bit<=cnt_bit+1;
    end
end



reg en_1,en_0,en_2,en_pose;

always @(posedge clk)begin
        en_0<=en;
        en_1<=en_0;
        en_2<=en_1;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        en_pose<=0;
    end else if(en_0&!en_1&!en_2)begin
                en_pose<=1;
    end else begin
        en_pose<=0;
    end
    
end

integer num_bit;
reg en_bps;
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        en_bps<=0;
    end else  if(en_pose)begin
        en_bps<=1;
    end else if(num_bit == 10 )begin
        en_bps<=0;
    end
end





reg tx_reg;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        num_bit <= 0;
    end else if(en_bps) begin
        if(bit_start) begin
            case (num_bit)
                0: tx_reg <= 0;
                1: tx_reg <= tx_data[0];
                2: tx_reg <= tx_data[1];
                3: tx_reg <= tx_data[2];
                4: tx_reg <= tx_data[3];
                5: tx_reg <= tx_data[4];
                6: tx_reg <= tx_data[5];
                7: tx_reg <= tx_data[6];
                8: tx_reg <= tx_data[7];
                9: tx_reg <= 1;
                
                default: ; // Do nothing
            endcase
            num_bit <= num_bit + 1;
        end
    end else begin
        num_bit<=0;
        tx_reg<=1;
    end
end
assign tx = tx_reg;


endmodule