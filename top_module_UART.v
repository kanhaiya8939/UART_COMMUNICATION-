module uart_top(input rst,input [7:0]data_in,input wr_en,clk,input rdy_clr,output rdy,busy,output [7:0]data_out);

wire rx_clk_en; 
wire tx_clk_en;


wire tx_temp;

baud_rate_generator b_a(.clk(clk),.reset(rst),.tx_enable(tx_clk_en),.rx_enable(rx_clk_en));

transmetter t_a(.clk(clk) ,.wr_enable(wr_en),.enb(tx_clk_en),.rst(rst),.data_in(data_in),.tx_serial(tx_temp),.busy(busy));


uart_recieaver R_a(.clk(clk) ,.rst(rst) ,.rx(tx_temp),.rdy_clr(rdy_clr),.clk_en(rx_clk_en),
.rdy(rdy),.data_out(data_out));
endmodule
