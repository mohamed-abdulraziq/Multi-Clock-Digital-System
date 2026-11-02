module Pulse_Generation 
(
input    wire                      clk,
input    wire                      rst,
input    wire                      in_data,
output   wire                      pulse
);
reg              in_flop, pulse_flop  ;
reg              in_data_seq ;

assign pulse = in_flop && !pulse_flop ;
	
always @(posedge clk or negedge rst)
 begin
  if(!rst)      
   begin
     in_data_seq <= 1'b0 ;	
   end
  else
   begin
     in_data_seq <= in_data ;
   end  
 end
	
always @(posedge clk or negedge rst)
 begin
  if(!rst)      
   begin
    in_flop <= 1'b0 ;
    pulse_flop <= 1'b0 ;	
   end
  else
   begin
    in_flop <= in_data_seq;   
    pulse_flop <= in_flop;
   end  
 end
endmodule