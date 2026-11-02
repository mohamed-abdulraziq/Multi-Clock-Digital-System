module FIFO_MEM_CNTRL_mohamed_abdulrazeq #(parameter DATA_WIDTH = 8)
(
 input   wire                          wclk_mem,
 input   wire                          wrst_mem,
 input   wire                          wincr_mem,
 input   wire                          wfull_mem,
 input   wire                          rincr_mem,
 input   wire [((DATA_WIDTH)-1):0]   wdata_mem, 
 input   wire [((DATA_WIDTH/2)-2):0]   radder_mem,
 input   wire [((DATA_WIDTH/2)-2):0]   wadder_mem, 
 output  wire [((DATA_WIDTH)-1):0]   rdata_mem
);
////////////////////////////////////////////////////
reg [DATA_WIDTH-1:0] i ;
wire 					wclken ;
reg [((DATA_WIDTH)-1):0]  memory [(DATA_WIDTH-1):0] ;
////////////////////////////////////////////////////
assign wclken 	 =  ~wfull_mem & wincr_mem ;
assign rdata_mem = memory[radder_mem] ;

////////////////////////////////////////////////////
always@(posedge wclk_mem or negedge wrst_mem)
	begin
		if (!wrst_mem)
			begin 
			    for(i=0;i<DATA_WIDTH;i=i+1) 
					memory[i] <= {(2*DATA_WIDTH){1'b0}} ;
			end 
		else if (wclken)	
			begin 
				memory[wadder_mem] <=  wdata_mem ;
			end
	end 
endmodule