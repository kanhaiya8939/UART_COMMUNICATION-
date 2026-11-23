module baud_rate_generator(input clk,reset ,output tx_enable,rx_enable);
reg [12:0]tx_counter;
reg [9:0]rx_counter;
always @(posedge clk) begin
  if(reset)begin
  tx_counter<=13'b0;
  rx_counter<=10'b0;
  end 
else begin
  if(rx_counter == 325)begin
rx_counter<=0;
  end
  else begin
  rx_counter <= rx_counter +1'b1;
  end


  if(tx_counter == 5208)begin
tx_counter<=0;
  end
  else begin
  tx_counter <= tx_counter +1'b1;
  end


end
end
assign tx_enable = (tx_counter==0)?1'b1 : 1'b0;
assign rx_enable = (rx_counter==0)?1'b1 : 1'b0;

endmodule

