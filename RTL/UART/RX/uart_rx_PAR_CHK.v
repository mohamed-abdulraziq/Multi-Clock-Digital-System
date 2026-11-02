module uart_rx_PAR_CHK_mohamed_abdulrazeq
(
input  wire        clk_P, 
input  wire        rst_P,
input  wire        PAR_TYP_P,
input  wire        PAR_chk_En_P,
input  wire  [5:0] Cnt_edge_P,
input  wire  [5:0] Prescale_P,
input  wire  [2:0] Sampled_P,
input  wire  [7:0] P_Data_in_P,
output reg         PAR_err_P
);
reg       parity ;

always @ (*)
  begin
    case(PAR_TYP_P)
    1'b0 : begin                 
	        parity = ^P_Data_in_P  ;     // Even Parity
	       end
    1'b1 : begin
	        parity = ~^P_Data_in_P ;     // Odd Parity
	       end		
    endcase       	 
 end 
 
always@(posedge clk_P or negedge rst_P)
  begin 
    if (!rst_P)
      begin 
        PAR_err_P <= 1'b0 ;
      end
    else if(PAR_chk_En_P && Cnt_edge_P == Prescale_P - 2)
	  begin
		PAR_err_P <= parity ^ Sampled_P[0] ;
      end	  
  end
endmodule
