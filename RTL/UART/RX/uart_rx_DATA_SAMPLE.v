module uart_rx_DATA_SAMPLIE_mohamed_abdulrazeq
(
input    wire         clk_DA,
input    wire         rst_DA,
input    wire         Ser_Data_DA,
input    wire  [5:0]  Prescale_DA, 
input    wire  [5:0]  edge_cnt_DA,
input    wire         Data_Samp_En_DA, 
output   reg   [2:0]  samples_DA,
output   reg   [2:0]  Sampled_DA  
);

wire [3:0]  HALF_SCALE ;


assign HALF_SCALE = ((Prescale_DA >> 1) - 1) ;

always@(posedge clk_DA or negedge rst_DA)
  begin 
    if(!rst_DA)
      begin 
        Sampled_DA <= 3'b0 ;
        samples_DA <= 3'b0 ;
      end
    else if (Data_Samp_En_DA) 
      begin 
        if (edge_cnt_DA == (HALF_SCALE - 1) | edge_cnt_DA == (HALF_SCALE)| edge_cnt_DA == (HALF_SCALE + 1))
          begin 
            samples_DA[edge_cnt_DA - (HALF_SCALE - 1)] <= Ser_Data_DA ;
          end 
	    else
          begin
            Sampled_DA <= (samples_DA[2] + samples_DA[1] + samples_DA[0] >> 1) ;
          end 
      end
	else if (!Data_Samp_En_DA)  
	  begin
	    Sampled_DA <= 3'b111 ;
        samples_DA <= 3'b111 ;
	  end
  end
endmodule