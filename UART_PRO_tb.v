
`include "baudrate.v"
`include "UART.v"
`include "receiver.v"
`include "top_module_UART.v"



module UART_tb;

    reg        clk, rst;
    reg  [7:0] data_in;
    reg        wr_en;
    reg        rdy_clr;

    wire       rdy;
    wire [7:0] d_out;
    wire       busy;

    uart_top uut (
        .rst      (rst),
        .data_in  (data_in),
        .wr_en    (wr_en),
        .clk      (clk),
        .rdy_clr  (rdy_clr),
        .rdy      (rdy),
        .busy     (busy),
        .data_out (d_out)
    );

  
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end


    initial begin
        $fsdbDumpfile("UART.fsdb");
        $fsdbDumpvars(0, UART_tb);
    end

   
    task send_byte(input [7:0] din);
        begin
            @(posedge clk);
            data_in = din;
            wr_en   = 1'b1;
            @(posedge clk);
            wr_en   = 1'b0;
        end
    endtask

    task clear_ready;
        begin
            @(posedge clk);
            rdy_clr = 1'b1;
            @(posedge clk);
            rdy_clr = 1'b0;
        end
    endtask

   
    initial begin
        
        rst     = 1'b1;
        wr_en   = 1'b0;
        rdy_clr = 1'b0;
        data_in = 8'h00;

       
        @(posedge clk);
        @(posedge clk);
        rst = 1'b0;

      
        send_byte(8'h41);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;
        
      send_byte(8'h51);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h91);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h11);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h10);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h45);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h46);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h49);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h43);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

 send_byte(8'h42);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;
 send_byte(8'h67);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;
        
 send_byte(8'h99);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;


        send_byte(8'h55);
        wait (!busy);
        wait (rdy);
        $display("Received data is %h", d_out);
        clear_ready;

        #4000;
        $finish;
    end

endmodule
