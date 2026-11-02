module UART_TX_Serializer_mohamed_abdulrazeq (
input   wire   [7:0]  P_Data_S ,
input   wire          Ser_En_S ,
input   wire          rst_S ,
input   wire          clk_S ,
input   wire          Valid_S ,
input   wire          temp_S ,
input   wire          Busy_S ,
output  reg           Ser_Data_S ,
output  reg           Ser_Done_S
);

reg   Ser_Done_C ;
reg       [7:0]       Data ;

integer               n ;

always@(posedge clk_S or negedge rst_S)
  begin
    if (!rst_S)
      begin
        Data <= 8'b0 ;
        Ser_Data_S <= 1'b0 ;
      end
    else if (Valid_S && !Busy_S)
      begin
        Data <= P_Data_S ;
      end
   else if (Ser_En_S)
    begin
      Ser_Data_S <= Data[0] ;
      Data <= Data >> 1 ;
    end
  end

always@(posedge clk_S or negedge rst_S)
  begin
    if (!rst_S)
      begin
        Ser_Done_S <= 1'b0 ;
      end
    else
      begin
        Ser_Done_S <= Ser_Done_C ;
      end
  end

always@(*)
  begin
    if (temp_S)
      begin
        Ser_Done_C = 1'b1 ;
      end
    else
      begin
        Ser_Done_C = 1'b0 ;
      end
  end
endmodule
