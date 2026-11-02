module RegFile_8x16_mohamed_abdulrazeq #(parameter DATA_WIDTH = 8, DEPTH = 16 , ADDR = 4)
(
input   wire [DATA_WIDTH-1:0]  Wrdata,
input   wire [ADDR-1:0]        Address,
input   wire              	   WrEn,
input   wire             	   RdEn,
input   wire              	   RST,
input   wire              	   CLK,
output  reg  [DATA_WIDTH-1:0]  Rddata,
output  reg    			  	   Rddata_VLD,
output  wire [DATA_WIDTH-1:0]  REG0,
output  wire [DATA_WIDTH-1:0]  REG1,
output  wire [DATA_WIDTH-1:0]  REG2,
output  wire [DATA_WIDTH-1:0]  REG3
);

reg [DATA_WIDTH-1:0] MEM [DEPTH-1:0];
integer i ;

assign REG0 = MEM[0] ;
assign REG1 = MEM[1] ;
assign REG2 = MEM[2] ;
assign REG3 = MEM[3] ;


always@(posedge CLK or negedge RST)
  begin 
    if (!RST)
      begin
	    for (i = 0 ; i < DEPTH ; i = i + 1)
		  begin 
		    if (i == 0)
		      begin 
    		    MEM[i] <= 'b00000101 ;  //// initial A 
			  end 
			else if (i == 1)
		      begin 
    		    MEM[i] <= 'b00001000 ;  //// initial B 
			  end 	
		    else if (i == 2)
		      begin 
    		    MEM[i] <= 'b100000_0_1 ;
			  end 
			else if (i == 3)
			  begin 
                MEM[i] <= 'b0010_0000 ;
			  end	
			else 
			  begin
			    MEM[i] <= 'b0 ;
			  end
		  end
        Rddata <= 'b0 ;
		Rddata_VLD <= 1'b0 ;
      end  
    else if (WrEn && !RdEn)  
      begin
        MEM[Address] <= Wrdata ;
      end
    else if (RdEn && !WrEn)
      begin 
        Rddata <= MEM[Address] ;
		Rddata_VLD <= 1'b1 ;
      end
	else 
      begin
		Rddata_VLD <= 1'b0 ;
	  end 	
  end
endmodule