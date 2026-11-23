module transmetter(input clk ,wr_enable,enb,rst,
 input [7:0]data_in,
 output reg tx_serial,
 output busy
);
localparam[1:0] IDLE = 2'b00,
       START = 2'b01,
       DATA = 2'b10,
       STOP = 2'b11;

reg [7:0]data;
reg [2:0]index;
reg [1:0]stage,next_stage;


  // this a same part of the sequentional circuit 
  always @(posedge clk)begin
        //solve all problem of the infeerd latch
        //next_stage <= stage;
        if (rst == 1'b1) begin
          tx_serial <= 1'b1;
          stage     <= IDLE;
          data  <= 8'b00000000;
          index <= 3'b000;
        end
        else begin
         stage <= next_stage;
           case(stage)
             IDLE : begin
                 tx_serial <= 1'b1;

 	       if(wr_enable == 1)begin
                 //stage <= START;
                 data <= data_in;
                 index <= 3'b000; 
               end
         //  else begin
           //stage <= IDLE; 
          // end
         end


        START : begin
          if(enb)begin
           // stage <= DATA;
            tx_serial <=1'b0;
          end
         // else begin
          //stage <= START;
          //end
        end

 DATA : begin 
         if(enb)begin
         tx_serial <= data[index]; 
         if(index != 3'b111)begin
         index <= index + 3'b001;
         end
        
         end
         end
 STOP : begin
         if(enb)begin
         tx_serial <= 1'b1;
         //stage <= IDLE;
         end
        end
 default : begin
 tx_serial <= 1'b1;
 //stage <= IDLE;
 end 

 endcase
 end
 end 


//this a same part os the combinational circuit 
 
always @(*)begin
//this is a state ment are cover to all the solve problem of infeerd letch
   next_stage  = stage;
  case(stage)
    IDLE:begin
          if(wr_enable == 1'b1)
          next_stage = START;
         end 

         START :begin 
          if(enb)
          next_stage = DATA;
         end

    DATA :begin
    if(enb && (index == 3'b111))begin
    next_stage = STOP;
    end
    end

     STOP:begin
    if(enb) 
    next_stage = IDLE;

    end

    default :begin
    next_stage = IDLE;
    end
   
     endcase

    end 


 assign busy = (stage != IDLE);


endmodule 
