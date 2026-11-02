module FIFO_TOP_mohamed_abdulrazeq # (parameter DATA_WIDTH = 8)
(
 input   wire                          W_clk,
 input   wire                          W_rst,
 input   wire                          R_clk,
 input   wire                          R_rst,
 input   wire                          W_INC,
 input   wire                          R_INC,
 input   wire   [DATA_WIDTH-1:0]       WR_DATA,
 output  wire   [DATA_WIDTH-1:0]       RD_DATA, 
 output  wire                          EMPTY,
 output  wire                          FULL
);

wire [((DATA_WIDTH/2)-2):0]  radd ;
wire [((DATA_WIDTH/2)-2):0]  wadd ;
wire [((DATA_WIDTH/2)-1):0]  Wptr_t ;
wire [((DATA_WIDTH/2)-1):0]  Rptr_t ;
wire [((DATA_WIDTH/2)-1):0]  wptr_s ;
wire [((DATA_WIDTH/2)-1):0]  rptr_s ;



FIFO_MEM_CNTRL_mohamed_abdulrazeq #( .DATA_WIDTH(8)) MEM
(
.wclk_mem		(W_clk),
.wrst_mem		(W_rst),
.wincr_mem		(W_INC),
.rincr_mem      (R_INC),
.wfull_mem		(FULL),
.wdata_mem		(WR_DATA), 
.radder_mem		(radd),
.wadder_mem		(wadd), 
.rdata_mem      (RD_DATA)
);

FIFO_WR_mohamed_abdulrazeq #( .DATA_WIDTH(8)) WRITE
(
.wclk			(W_clk),
.wrst			(W_rst),
.wincr			(W_INC),
.wfull			(FULL),
.rptr_w			(rptr_s),
.wadder 		(wadd), 
.wptr	        (Wptr_t)
);

FIFO_RD_mohamed_abdulrazeq #( .DATA_WIDTH(8)) READ
(
.rclk			(R_clk),
.rrst			(R_rst),
.rincr			(R_INC),
.rempty			(EMPTY),
.wptr_r			(wptr_s),
.radder 		(radd), 
.rptr	        (Rptr_t)
);

DF_SYNC_w2r_mohamed_abdulrazeq #(.NUM_STAGES(2) , .BUS_WIDTH(4)) SYNC_W2R (
.CLK(R_clk) ,
.RST(R_rst) ,
.ASYNC(Wptr_t) ,
.SYNC(wptr_s)
);

DF_SYNC_r2w_mohamed_abdulrazeq #(.NUM_STAGES(2) , .BUS_WIDTH(4)) SYNC_R2W (
.CLK(W_clk) ,
.RST(W_rst) ,
.ASYNC(Rptr_t) ,
.SYNC(rptr_s)
);

endmodule