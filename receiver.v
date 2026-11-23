module uart_recieaver(input clk ,rst ,rx,rdy_clr,clk_en,
output reg rdy,
output reg[7:0]data_out);

localparam[1:0] START = 2'b00,
 DATA_OUT_STATE = 2'b01,
 STOP = 2'b10;


reg [1:0]state,next_state;
reg [3:0]sample;
reg [2:0]index;
reg [7:0]temp_register;

always @(posedge clk)begin

          if(rst)begin
           rdy <= 1'b0;
           data_out <= 8'b00000000;
           sample <= 4'b0000;
           index <= 3'b000;
           temp_register <= 8'b00000000;
           state <=  START;
          end 

 else begin
           
        state <= next_state; 
           if(rdy_clr)begin
           rdy <= 1'b0;
           end
  

           else if(clk_en)begin
         
           case (state) 
           START :begin

           if(sample == 4'd15)begin
           //state <=  DATA_OUT_STATE;
           sample <=4'b0;
           index <= 3'b0;
           temp_register <= 8'b0;
           end 

           else if((rx == 1'b0) || (sample !=1'b0))begin
           sample <= sample+4'b1;
           end 
  
         
        end


   DATA_OUT_STATE : begin
  
     if(sample == 4'h8) begin
         temp_register[index] <= rx;
         //index <= index+1'b1;
     end

    
     if(sample == 4'd15)begin
        sample <= 1'b0;
     if(index != 3'd7)begin
        //state <= STOP;
        index <= index+3'b1;
     end
     end
    else begin
    sample <= sample+4'b1;
    end

  end
  STOP : begin

   if(sample ==4'd15)begin
  //state <= START;
   data_out <= temp_register;
  rdy <= 1'b1;
  sample <= 4'b0;
  end
  
  else begin
   sample <= sample + 4'b1;
  end 
 end

  default : begin
   sample <=4'b0;
  //state <= START;
  end 
  endcase
  end//if (clk_en ka end hai )

  end //else condition ka end hai 
 end // always block ka and hai 
 
//this is same part of the combinatiaol block
 always @(*)begin
      next_state = state; 
    if(clk_en)begin
     case(state)
      START :begin
       if(sample ==  4'd15 )begin
        next_state = DATA_OUT_STATE;
        end
      end 
    
       DATA_OUT_STATE:begin
       if((sample ==  4'd15)&&(index==3'd7))begin
         next_state = STOP;
        end

        end
       
     STOP :begin
     if(sample == 4'd15)begin
      next_state = START;
     end
  
     end
     default :begin
   next_state = START;
      end
endcase

end
 end

endmodule
