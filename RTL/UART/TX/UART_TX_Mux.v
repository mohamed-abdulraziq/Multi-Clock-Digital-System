module UART_TX_MUX_mohamed_abdulrazeq (
input   wire           Ser_Data_M ,
input   wire   [1:0]   Sel_M ,
input   wire           PAR_b_M ,
output  reg            S_data_M 
);
always@(*)
  begin
    case (Sel_M)
        2'b00: S_data_M = 1'b0 ;  /// Start_Bit
        2'b01: S_data_M = 1'b1 ;  /// Stop_Bit 
        2'b10: S_data_M = Ser_Data_M ; 
        2'b11: S_data_M = PAR_b_M ; 
    endcase
  end
endmodule