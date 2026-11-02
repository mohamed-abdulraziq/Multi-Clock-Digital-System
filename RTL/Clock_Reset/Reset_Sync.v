module Reset_Sync_mohamed_abdulrazeq #(parameter width = 7)
(
input  wire  clk,
input  wire  rst,
output reg   sync_rst
);

reg [(width-1):0] sync ; 

always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        sync <= 'b0 ;  
        sync_rst <= 1'b0 ;
      end
    else
      begin
        sync <= {sync[width-2:0], 1'b1} ; 
        sync_rst <= sync[width-2] ; 
      end
  end
endmodule