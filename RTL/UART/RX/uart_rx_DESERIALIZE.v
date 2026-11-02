module uart_rx_DESERIALIZE_mohamed_abdulrazeq
(
input  wire        clk_DS, 
input  wire        rst_DS,
input  wire [2:0]  Sampled_DS,
input  wire        Desser_En_DS,
input  wire [5:0]  Prescale_DS,
input  wire        DATA_Valid_DS,
input  wire [3:0]  Cnt_bit_DS,
input  wire [5:0]  Cnt_edge_DS,
output reg  [7:0]  P_Data_in_DS,
output reg  [7:0]  P_Data_DS
);

 
wire   [5:0]  Half_Scale ;

assign Half_Scale = (Prescale_DS - 2) ;

always@(posedge clk_DS or negedge rst_DS)
  begin 
    if (!rst_DS)
      begin
        P_Data_DS <= 8'b0 ;
        P_Data_in_DS <= 8'b0 ;
      end
    else if (Desser_En_DS && Cnt_edge_DS == Half_Scale)
      begin 
        P_Data_in_DS <= {Sampled_DS[0],P_Data_in_DS[7:1]}	;
      end
	else  
      begin 
        P_Data_DS <= P_Data_in_DS ;
      end
  end 
endmodule