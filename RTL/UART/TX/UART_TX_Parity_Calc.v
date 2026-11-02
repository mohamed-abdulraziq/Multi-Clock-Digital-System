module UART_TX_Parity_Calc_mohamed_abdulrazeq (
input   wire          clk_PC ,
input   wire          rst_PC ,
input   wire   [7:0]  P_Data_PC ,
input   wire          Valid_PC ,
input   wire          Parity_TYP ,
input   wire          Busy_PC,
output  reg           PAR_b_PC 
);

reg [7:0] DATA ;

always@(posedge clk_PC or negedge rst_PC)
  begin 
    if (!rst_PC)
	  begin 
		DATA <= 8'b0 ;
		PAR_b_PC <= 1'b0 ;
	  end
    else if (!Busy_PC)
	  begin
		DATA = P_Data_PC ;
	  end	
    else if (!Parity_TYP)  /////////  EVEN_Parity
      begin
        PAR_b_PC <= ^DATA ;
      end
    else             /////////  ODD_Parity
      begin
        PAR_b_PC <= ~(^DATA) ;
      end 
  end
endmodule