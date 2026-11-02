module FIFO_WR_mohamed_abdulrazeq #(parameter DATA_WIDTH = 8)
(
 input   wire                          wclk,
 input   wire                          wrst,
 input   wire                          wincr,
 input   wire [((DATA_WIDTH/2)-1):0]   rptr_w, 
 output  reg  [((DATA_WIDTH/2)-1):0]   wptr,
 output  wire                          wfull,
 output  wire [((DATA_WIDTH/2)-2):0]   wadder
);

 reg [((DATA_WIDTH/2)-1):0]  wptr_bin ;
 
assign wfull = (wptr[3] != rptr_w[3] && wptr[2] != rptr_w[2] && wptr[1:0] == rptr_w[1:0]) ;
assign wadder = wptr_bin[2:0] ;

always@(posedge wclk or negedge wrst)
	begin
		if (!wrst)
			begin
				wptr_bin <=  'b0 ; 
			end 
		else if (wincr && !wfull)
			begin
				wptr_bin <= wptr_bin + 'b1 ;
			end
	end 
		
always @(posedge wclk or negedge wrst)
  begin
    if(!wrst)
	  begin
        wptr <= 0 ;
      end
    else
	  begin
		case (wptr_bin) 
			4'b0000: wptr <= 4'b0000 ;
			4'b0001: wptr <= 4'b0001 ;
			4'b0010: wptr <= 4'b0011 ;
			4'b0011: wptr <= 4'b0010 ;
			4'b0100: wptr <= 4'b0110 ;
			4'b0101: wptr <= 4'b0111 ;
			4'b0110: wptr <= 4'b0101 ;
			4'b0111: wptr <= 4'b0100 ;
			4'b1000: wptr <= 4'b1100 ;
			4'b1001: wptr <= 4'b1101 ;
			4'b1010: wptr <= 4'b1111 ;
			4'b1011: wptr <= 4'b1110 ;
			4'b1100: wptr <= 4'b1010 ;
			4'b1101: wptr <= 4'b1011 ;
			4'b1110: wptr <= 4'b1001 ;
	 		4'b1111: wptr <= 4'b1000 ;
		endcase 
	  end   
  end 
endmodule