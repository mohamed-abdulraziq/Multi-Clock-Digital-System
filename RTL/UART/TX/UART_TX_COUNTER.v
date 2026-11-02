module UART_TX_COUNTER_mohamed_abdulrazeq 
(
input  wire          clk_c,
input  wire          Count_En_c, //////    connected to Ser_En_S
input  wire          rst_c, 
output wire          done_c      //////    connected to temp_S --------> Ser_Done_S    
);

reg   [2:0]   Counter ;

assign done_c = (Counter == 3'b111) ;

always @(posedge clk_c or negedge rst_c) 
  begin
    if (!rst_c)
      begin
        Counter <= 3'b0; // Reset counter to 0
      end
    else if (Count_En_c)  
      begin
        Counter <= Counter + 1 ; // Increment counter    
       end
    else  
      begin
        Counter <= 3'b0 ; 
      end
  end  
endmodule