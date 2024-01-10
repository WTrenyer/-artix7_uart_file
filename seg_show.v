module seg(
    input clk,rst_n,
    input[4:0]  num,

    output reg[7:0]seg

);
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        seg =   8'b1001_1001;
    end else 
        case(num)
			4'b0000: seg =   8'b1100_0000;
			4'b0001: seg =   8'b1111_1001;
			4'b0010: seg =   8'b1010_0100;
			4'b0011: seg =   8'b1011_0000;
			4'b0100: seg =   8'b1001_1001;
			4'b0101: seg =   8'b1001_0010;
			4'b0110: seg =   8'b1000_0010;
			4'b0111: seg =   8'b1111_1000;
			4'b1000: seg =   8'b1000_0000;
			4'b1001: seg =   8'b1001_0000;
			4'b1010: seg =   8'b1000_1000;
            4'b1011: seg =   8'b1000_0011;
            4'b1100: seg =    8'b1100_0110;
            4'b1101: seg =    8'b1010_0001;
            
            4'b1110: seg =   8'b1000_0110;
            4'b1111: seg =   8'b1000_1110;
			default:seg =     8'b11111111;
       endcase

end

endmodule