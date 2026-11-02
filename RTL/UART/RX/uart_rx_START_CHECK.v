
module uart_rx_START_CHECK_mohamed_abdulrazeq 
(
input  wire       srt_chk_En_ST, 
input  wire [2:0] Sampled_ST,
input  wire [5:0] Cnt_edge_ST,
input  wire [5:0] Prescale_ST,
output reg        srt_err_ST
);

always@(*)
  begin 
    if (srt_chk_En_ST && Sampled_ST[0] && Cnt_edge_ST == ((Prescale_ST - 1)))
      begin
        srt_err_ST = 1'b1 ;
      end
    else 
      begin
        srt_err_ST = 1'b0 ;
      end
  end    
endmodule