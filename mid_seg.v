module mid_seg(
    input clk,rst_n,
    input [7:0]num,
    output reg[6:0]ctrl,
    output [7:0]seg_out
);



    reg [25:0] cnt; // 26-bit counter
    reg sign;
    always @(posedge clk) begin
//        if(cnt == 49999) begin // 50MHz / 50000 = 1kHz (1ms period)
if(!rst_n)begin
cnt <=0;
end else if(cnt == 49999) begin // 50MHz / 50000 = 1kHz (1ms period)
            cnt <= 0;          // Reset counter
            sign <= 1;       // Toggle output signal
        end else begin
            sign <= 0;    // Increment counter
            cnt = cnt+1;
        end
    end





reg pla;
reg[3:0]num_show;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        pla <= 0;
        ctrl<=0;
        num_show<=0;
    end else if(sign)begin
        case (pla)
            0: begin
                pla<=1;
                ctrl <= 6'b111110;
                num_show<=num[3:0];
            end
            1:begin
                pla<=0;
                ctrl <= 6'b111101;
                num_show<=num[7:4];
            end

        endcase
        end
end


seg uut(
    .clk(clk),
    .rst_n(rst_n),
    .num(num_show),
    .seg(seg_out)
);


endmodule