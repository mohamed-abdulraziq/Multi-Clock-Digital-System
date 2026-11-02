module UART_TX_TOP_mohamed_abdulrazeq(
input  wire  [7:0]  P_Data ,
input  wire         Data_Valid ,
input  wire         rst ,
input  wire         clk ,
input  wire         PAR_En ,
input  wire         PAR_TYP ,
output wire         TX_OUT ,
output wire         Busy
);

wire        Ser_En ;
wire        Counter_En ;
wire        Ser_done ;
wire        done ;
wire        ser_data ;
wire  [1:0] Mux_Sel ;
wire        Par_b ;


UART_TX_FSM_mohamed_abdulrazeq FSM
(.clk_F              (clk),
 .rst_F              (rst),
 .PAR_En_F           (PAR_En),
 .Data_Valid_F       (Data_Valid),
 .Ser_Done_F         (Ser_done),
 .Busy_F             (Busy),
 .Count_En_F         (Counter_En),
 .Ser_En_F           (Ser_En),
 .Mux_Sel_F          (Mux_Sel)
);

UART_TX_Serializer_mohamed_abdulrazeq Serializer
(.clk_S              (clk),
 .rst_S              (rst),
 .Valid_S            (Data_Valid),
 .Ser_Done_S         (Ser_done),
 .Ser_En_S           (Ser_En),
 .temp_S             (done),
 .Busy_S             (Busy),
 .Ser_Data_S         (ser_data),
 .P_Data_S           (P_Data)
);

UART_TX_Parity_Calc_mohamed_abdulrazeq Parity
(
 .clk_PC             (clk),
 .rst_PC			 (rst),
 .P_Data_PC          (P_Data),
 .Parity_TYP         (PAR_TYP),
 .PAR_b_PC           (Par_b),
 .Busy_PC			 (Busy),
 .Valid_PC           (Data_Valid)
);

UART_TX_MUX_mohamed_abdulrazeq MUX
(.Ser_Data_M         (ser_data),
 .Sel_M              (Mux_Sel),
 .PAR_b_M            (Par_b),
 .S_data_M           (TX_OUT)
);

UART_TX_COUNTER_mohamed_abdulrazeq Count
(.clk_c              (clk),
 .rst_c              (rst),
 .Count_En_c         (Counter_En),
 .done_c             (done)
);

endmodule