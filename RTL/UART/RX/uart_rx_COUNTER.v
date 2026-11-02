module uart_rx_COUNTER_mohamed_abdulrazeq 
(
input  wire        clk_c, 
input  wire        rst_c,
input  wire        Cnt_En_c,
input  wire        PAR_En_c,
input  wire        CUN_Zero_c,
input  wire [5:0]  Prescale_c,
output reg  [5:0]  Cnt_edge_c,
output reg  [3:0]  Cnt_bit_c
);

wire cnt_zero;
wire cnt_zero2;

assign cnt_zero  = (Cnt_edge_c == (Prescale_c - 6'b1)) ? 1'b1 : 1'b0 ; 

always@(posedge clk_c or negedge rst_c)
  begin
    if(!rst_c)
	  begin
	    Cnt_edge_c <= 6'b0 ;
		Cnt_bit_c <= 4'b0 ;
	  end
	else if (Cnt_En_c)  
	  begin
	    if (cnt_zero)
            begin
              Cnt_edge_c <= 6'b0 ;
			  Cnt_bit_c <= Cnt_bit_c + 4'b1 ;
            end
        else
          begin
            Cnt_edge_c <= Cnt_edge_c + 6'b1 ;
          end  
      end
	else 
      begin
		Cnt_edge_c <= 6'b0 ;
		Cnt_bit_c <= 4'b0 ;
	  end	
  end
endmodule