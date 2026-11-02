module PRESCALE_MUX 
(
input  wire [5:0]  prescale,
output reg  [7:0]  DIV_RAT 
);

always@(*)
	begin
      case (prescale)
		6'd32 : DIV_RAT = 1 ;
		6'd16 : DIV_RAT = 2 ;
		6'd8  : DIV_RAT = 4 ;
		default : DIV_RAT = 1 ;
	  endcase 	
 	end
endmodule