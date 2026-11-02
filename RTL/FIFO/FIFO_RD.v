module FIFO_RD_mohamed_abdulrazeq #(parameter DATA_WIDTH = 8)
(
 input   wire                          rclk,
 input   wire                          rrst,
 input   wire                          rincr,
 input   wire [((DATA_WIDTH/2)-1):0]   wptr_r, 
 output  reg  [((DATA_WIDTH/2)-1):0]   rptr,
 output  wire                          rempty,
 output  wire  [((DATA_WIDTH/2)-2):0]   radder
);

 reg [((DATA_WIDTH/2)-1):0]  rptr_bin ;
 
 
 assign rempty = (rptr == wptr_r) ;
 assign radder = rptr_bin[2:0] ;

 
always@(posedge rclk or negedge rrst)
	begin
		if (!rrst)
			begin
				rptr_bin <=  'b0 ; 
			end 
		else if (rincr && !rempty)
			begin
				rptr_bin <= rptr_bin + 'b1 ;
			end
		
	end 

always @(posedge rclk or negedge rrst)
  begin
    if(!rrst)
      begin
        rptr <= 0 ;
      end
    else 
      begin
        case (rptr_bin)
		  4'b0000: rptr <= 4'b0000 ;
		  4'b0001: rptr <= 4'b0001 ;
		  4'b0010: rptr <= 4'b0011 ;
		  4'b0011: rptr <= 4'b0010 ;
		  4'b0100: rptr <= 4'b0110 ;
		  4'b0101: rptr <= 4'b0111 ;
		  4'b0110: rptr <= 4'b0101 ;
		  4'b0111: rptr <= 4'b0100 ;
		  4'b1000: rptr <= 4'b1100 ;
		  4'b1001: rptr <= 4'b1101 ;
		  4'b1010: rptr <= 4'b1111 ;
		  4'b1011: rptr <= 4'b1110 ;
		  4'b1100: rptr <= 4'b1010 ;
		  4'b1101: rptr <= 4'b1011 ;
		  4'b1110: rptr <= 4'b1001 ;
		  4'b1111: rptr <= 4'b1000 ;
	    endcase
	  end
  end
endmodule