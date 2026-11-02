module CLK_Divider_mohamed_abdulrazeq(
input  wire         ref_clk ,
input  wire         rst , 
input  wire         clk_En ,
input  wire  [7:0]  Div_rat ,
output wire         Div_Clk
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire [5:0] half_period ;
wire [5:0] half_period_o ;
wire       clk_En_in ;
wire       odd ;
reg        flag = 1'b1 ;
reg  [5:0] Counter ;
reg        Div_Clk_O ;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign half_period = (Div_rat >> 1) - 1 ;
assign half_period_o = (Div_rat >> 1) - 1 ;
assign clk_En_in = clk_En && (Div_rat != 8'b0) && (Div_rat != 8'b1) ;
assign odd = Div_rat[0] ;
assign Div_Clk = clk_En_in ? Div_Clk_O : ref_clk ;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge ref_clk or negedge rst)
  begin
	
	if (!rst)
      begin 
        Div_Clk_O <= 1'b0 ;
        Counter <= 5'b0 ;
		flag <= 1'b1 ;
      end
    else if (clk_En_in && !odd && Counter == half_period)  
      begin
        Div_Clk_O <= !Div_Clk ;
        Counter <= 3'b0 ;
		if (Div_Clk_O)
		  begin
			flag <= 1'b1 ;
		  end
		else 
		  begin
    	    flag <= 1'b0 ;  
	      end
	end  
    else if (clk_En_in && odd && (((Counter == half_period_o + 1) && (flag == 1'b1)) | ((Counter == half_period_o) && (flag == 1'b0)))) 
      begin 
        Div_Clk_O <= !Div_Clk_O ;
        Counter <= 3'b0 ;
        flag <= !flag ;
      end    
    else if (!clk_En_in)
      begin
        Counter <= 5'b0 ;
      end 
	else  
	Counter <= Counter + 5'b1 ;  
  end
endmodule