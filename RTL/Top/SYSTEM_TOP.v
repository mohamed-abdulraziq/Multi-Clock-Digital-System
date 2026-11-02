module SYSTEM_TOP # (parameter DATA_WIDTH = 8, DEPTH = 16, ADDR = 4)
(
input  wire         	 	  	REF_CLK,
input  wire           		  	UART_CLK,
input  wire         		  	RST,
input  wire         		  	RX_IN,
output wire                     parity_error,
output wire                     framing_error,
output wire                  	TX_OUT
);
///////////////////////////////////////
wire           		  	UART_TX_CLK;
wire           		  	UART_RX_CLK;
wire  [DATA_WIDTH-1:0]  TX_IN_P;
wire         		  	TX_IN_V;
wire  [5:0]		      	Prescale;
wire          		  	PAR_En;
wire                  	BUSY;
wire          		  	PAR_TYP;
wire  [DATA_WIDTH-1:0]  RX_OUT_P;
wire  	    		  	RX_OUT_V;
wire         		  	TX_OUT_S;
wire         		  	TX_OUT_V;
wire          		  	Parity_Err;
wire  [7:0]			    Div_rat_in;
wire					REF_DOM_RST;  
wire					UART_DOM_RST;
///////////////////////////////////////
wire [ADDR-1:0]        Address;
wire [DATA_WIDTH-1:0]  Rddata;
wire [DATA_WIDTH-1:0]  REG0;//A
wire [DATA_WIDTH-1:0]  REG1;//B
wire [DATA_WIDTH-1:0]  REG2;
wire [DATA_WIDTH-1:0]  REG3;
//////////////////////////////////////////////////////////////////////////
wire                  	   ALU_CLK;//clk_gate
wire [ADDR-1:0]            ALU_FUN;//sys
wire [(2*DATA_WIDTH)-1:0]  ALU_OUT;//sys
//////////////////////////////////////////////////////////////////////////
wire         				RdDATA_VLD;
wire         				RX_D_VLD;
wire [DATA_WIDTH-1:0]    	RX_P_DATA;
wire         				ALU_OUT_VLD;
wire          				ALU_EN;
wire          				CLK_EN;
wire          				WrEn;
wire         	 			RdEn;
wire [DATA_WIDTH-1:0]   	Wrdata;
wire         	 			TX_DATA_V;
wire [DATA_WIDTH-1:0] 		TX_P_DATA;
wire         	 			clk_div_En;
//////////////////////////////////////////////////////////////////////////
wire                          W_INC;
wire                          R_INC;
wire   [DATA_WIDTH-1:0]       RD_DATA; 
wire                          EMPTY;
wire                          FULL;
//////////////////////////////////////////////////////////////////////////
SYS_CTRL_mohamed_abdulrazeq SYSTEM_CTRL
(
.clk(REF_CLK),
.rst(REF_DOM_RST),
.RdDATA_VLD(Rddata_VLD),
.RX_D_VLD(RX_D_VLD),
.FIFO_FULL(FULL),
.RdDATA(Rddata),
.RX_P_DATA(RX_P_DATA),
.ALU_OUT(ALU_OUT),
.ALU_OUT_VLD(ALU_OUT_VLD),
.ALU_EN(ALU_EN),
.ALU_FUN(ALU_FUN),
.CLK_EN(CLK_EN),
.Address(Address),
.WrEn(WrEn),
.RdEn(RdEn),
.WrData(Wrdata),
.TX_DATA_V(TX_DATA_V),
.TX_P_DATA(TX_P_DATA),
.clk_div_En(clk_div_En)
);
//////////////////////////////////////////////////////////////////////////
UART_TOP_mohamed_abdulrazeq UART
(
.TX_clk(UART_TX_CLK),
.RX_clk(UART_RX_CLK),
.rst(UART_DOM_RST),
.RX_IN_S(RX_IN),
.TX_IN_P(RD_DATA), //fifo
.TX_IN_V(!EMPTY), //fifo
.Prescale(REG2[7:2]),//RFreg2[7:2] 
.PAR_En(REG2[0]),
.PAR_TYP(REG2[1]),
.RX_OUT_P(RX_OUT_P),
.RX_OUT_V(RX_OUT_V),
.TX_OUT_S(TX_OUT),
.TX_OUT_V(BUSY), //pulse gen ---> rd_inc
.Parity_Err(parity_error),
.Stop_Err(framing_error)
);
//////////////////////////////////////////////////////////////////////////
CLK_Divider_mohamed_abdulrazeq CLK_DIV_TX
(
.ref_clk(UART_CLK),
.rst(UART_DOM_RST), 
.clk_En(clk_div_En), //
.Div_rat(REG3),//RFreg3[7:0]
.Div_Clk(UART_TX_CLK)
);
//////////////////////////////////////////////////////////////////////////
CLK_Divider_mohamed_abdulrazeq CLK_DIV_RX
(
.ref_clk(UART_CLK),
.rst(UART_DOM_RST), 
.clk_En(clk_div_En),//sys
.Div_rat(Div_rat_in),
.Div_Clk(UART_RX_CLK)
);
//////////////////////////////////////////////////////////////////////////
Data_Sync_mohamed_abdulrazeq DATA_Sync
(
.clk(REF_CLK),
.rst(REF_DOM_RST),
.Bus_En(RX_OUT_V),
.Un_Sync_Bus(RX_OUT_P),
.En_Pulse(RX_D_VLD),//ctrl
.Sync_Bus(RX_P_DATA) //ctrl
);
//////////////////////////////////////////////////////////////////////////
PRESCALE_MUX PRE_MUX
(
.prescale(REG2[7:2]), //RFreg2[7:2]
.DIV_RAT(Div_rat_in)
);
//////////////////////////////////////////////////////////////////////////
Reset_Sync_mohamed_abdulrazeq REF_RST_SYN
(
.clk(REF_CLK),
.rst(RST),
.sync_rst(REF_DOM_RST)
);
//////////////////////////////////////////////////////////////////////////
Reset_Sync_mohamed_abdulrazeq UART_RST_SYN
(
.clk(UART_CLK),
.rst(RST),
.sync_rst(UART_DOM_RST)
);
//////////////////////////////////////////////////////////////////////////
RegFile_8x16_mohamed_abdulrazeq REG_FILE
(
.Wrdata(Wrdata),
.Address(Address),
.WrEn(WrEn),
.RdEn(RdEn),
.RST(REF_DOM_RST),
.CLK(REF_CLK),
.Rddata(Rddata),
.Rddata_VLD(Rddata_VLD),
.REG0(REG0),
.REG1(REG1),
.REG2(REG2),
.REG3(REG3)
);
//////////////////////////////////////////////////////////////////////////
FIFO_TOP_mohamed_abdulrazeq FIFO
(
.W_clk(REF_CLK),
.W_rst(REF_DOM_RST),
.R_clk(UART_CLK),
.R_rst(UART_DOM_RST),
.W_INC(TX_DATA_V),
.R_INC(R_INC), // pulse gen ---> busy
.WR_DATA(TX_P_DATA),
.RD_DATA(RD_DATA), 
.EMPTY(EMPTY),
.FULL(FULL)
);
//////////////////////////////////////////////////////////////////////////
ALU_SYS ALU
(
.A(REG0), 
.B(REG1),
.EN(ALU_EN),//sys
.ALU_FUN(ALU_FUN),//sys
.CLK(ALU_CLK),
.RST(REF_DOM_RST),  
.ALU_OUT(ALU_OUT),
.OUT_VALID(ALU_OUT_VLD)  
);
//////////////////////////////////////////////////////////////////////////
clk_gating ClkGate
(
.CLK_EN(CLK_EN),//sys
.CLK(REF_CLK),
.GATED_CLK(ALU_CLK)
);
//////////////////////////////////////////////////////////////////////////
Pulse_Generation PULSE_GEN
(
.clk(UART_CLK),
.rst(UART_DOM_RST),
.in_data(BUSY),
.pulse(R_INC)
);
//////////////////////////////////////////////////////////////////////////
endmodule