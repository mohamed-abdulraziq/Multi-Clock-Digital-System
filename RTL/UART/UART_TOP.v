module UART_TOP_mohamed_abdulrazeq # (parameter DATA_WIDTH = 8)
(
input  wire         	 	  	TX_clk,
input  wire           		  	RX_clk,
input  wire         		  	rst,
input  wire         		  	RX_IN_S,
input  wire  [DATA_WIDTH-1:0]   TX_IN_P,
input  wire         		  	TX_IN_V,
input  wire  [5:0]		      	Prescale,
input  wire          		  	PAR_En,
input  wire          		  	PAR_TYP,
output wire  [DATA_WIDTH-1:0]   RX_OUT_P,
output wire  	    		  	RX_OUT_V,
output wire         		  	TX_OUT_S,
output wire         		  	TX_OUT_V,
output wire          		  	Parity_Err,
output wire      		      	Stop_Err
);

uart_rx_TOP_mohamed_abdulrazeq U0_UART_RX
(
.clk(RX_clk),
.rst(rst),
.RX_IN(RX_IN_S),
.Prescale(Prescale),
.PAR_En(PAR_En),
.PAR_TYP(PAR_TYP),
.P_Data(RX_OUT_P),
.Parity_Err(Parity_Err),
.Data_Valid(RX_OUT_V),       
.Stop_Err(Stop_Err)
);

UART_TX_TOP_mohamed_abdulrazeq U0_UART_TX
(
.P_Data(TX_IN_P),
.Data_Valid(TX_IN_V),
.rst(rst),
.clk(TX_clk),
.PAR_En(PAR_En),
.PAR_TYP(PAR_TYP),
.TX_OUT(TX_OUT_S),
.Busy(TX_OUT_V)
);
endmodule