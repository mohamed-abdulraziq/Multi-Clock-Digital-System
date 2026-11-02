module uart_rx_STP_CHK_mohamed_abdulrazeq
(
input  wire       clk_S, 
input  wire       rst_S,
input  wire       stp_chk_En_S, 
input  wire [2:0] Sampled_S,
input  wire [5:0] Cnt_edge_S,
input  wire [5:0] Prescale_S,
input  wire [2:0] samples_S,
output reg        stp_err_S
);

always@(posedge clk_S or negedge rst_S)
  begin 
    if (!rst_S)
      begin 
        stp_err_S <= 1'b0 ;
      end
	else if (stp_chk_En_S && samples_S[0] == 1'b0 && Cnt_edge_S == ((Prescale_S - 3)))
      begin
        stp_err_S <= 1'b1 ;
      end
	else 
	   begin 
        stp_err_S <= 1'b0 ;
      end  
  end    
endmodule