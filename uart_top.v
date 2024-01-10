module uart_top(
    input   clk,rst,
    input   rx,
    input   [3:0]btn,
    output   [3:0]led,
    output  [7:0]seg,
    output  [5:0]ctrl,
    output  tx

);
wire [7:0]rx_reg;;
assign led[1] = btn[0];
    uart_rx uut_rx(
        .clk(clk),
        .rst_n(rst),
        .rx (rx),
        .rx_data_out(rx_reg)
    );


    mid_seg seg_uut(
        .clk(clk),
        .rst_n(rst),
        .ctrl(ctrl),
        .num(rx_reg),
        .seg_out(seg)
    );
    ila_0 asd(
        .clk(clk),
        .probe0(rst),
        .probe1(btn)
    );
//    module ila_0 (
//    clk,
    
    
//    probe0,
//    probe1,
//    probe2
//    );
    
    uart_tx uut_tx(
        .clk(clk),
        .rst_n(rst),
        .tx (tx),
        .en(btn),
        .tx_data(7'b1100001)
    );


endmodule