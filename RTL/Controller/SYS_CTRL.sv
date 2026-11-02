module SYS_CTRL_mohamed_abdulrazeq #(parameter DATA_WIDTH = 8)
(
input  wire   	    				clk,
input  wire         				rst,
input  wire         				RdDATA_VLD,
input  wire         				RX_D_VLD,
input  wire [DATA_WIDTH-1:0]  		RdDATA,
input  wire [DATA_WIDTH-1:0]   	 	RX_P_DATA,
input  wire [(2*DATA_WIDTH)-1:0] 	ALU_OUT,
input  wire         				ALU_OUT_VLD,
input  wire         				FIFO_FULL,
output reg          				ALU_EN,
output reg  [(DATA_WIDTH/2)-1:0] 	ALU_FUN,
output reg          				CLK_EN,
output reg  [(DATA_WIDTH/2)-1:0]  	Address,
output reg          				WrEn,
output reg         	 				RdEn,
output reg  [DATA_WIDTH-1:0]   		WrData,
output reg         	 				TX_DATA_V,
output reg  [DATA_WIDTH-1:0] 		TX_P_DATA,
output reg         	 				clk_div_En
);

reg  Add_Store ;
reg  ALU_Store ;
reg  ALU_FUN_Store ;


reg  [(DATA_WIDTH/2)-1:0]  	Address_store ;
reg  [(DATA_WIDTH*2)-1:0]  	ALU_FRAME_store ;
reg  [(DATA_WIDTH/2)-1:0]  	ALU_FUNC_Store ;


typedef enum bit [3:0]{
                       RF_Wr_CMD                = 4'b0001 ,
                       IDLE_state               = 4'b0000 ,
                       RF_Wr_Add                = 4'b0010 ,
                       RF_Wr_Data               = 4'b0011 ,
                       RF_Rd_CMD                = 4'b0100 ,
                       RF_Rd_Addr               = 4'b0101 ,
                       ALU_OPER_W_OP_CMD        = 4'b0110 ,
                       Operand_A                = 4'b0111 ,
                       Operand_B                = 4'b1000 ,
                       ALU_OPERATION            = 4'b1001 ,
					   ALU_SEC_FRAME	     	= 4'b1101 ,
                       ALU_OPER_W_NOP_CMD       = 4'b1010 ,
					   FIFO_RF                  = 4'b1011 ,
					   FIFO_ALU                 = 4'b1100 
} State_e ;

State_e    current_state , next_state ;

/////// STATES Transition  ///////      
                    
always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        current_state <= IDLE_state ;
      end 
    else
      begin
        current_state <= next_state ;
      end   
  end
////////////// Next STATES && OUTPUT logic //////////////  
always@(*)
  begin
  ////////////////////////////////////////////////////////////////////// INITIALIZE OUTPUTS //////////////////////////////////////////////////////////////////////
    ALU_EN		= 1'b0 ;
    ALU_FUN		=  'b0 ;	
	CLK_EN		= 1'b0 ;
	Address     =  'b0 ;
	WrEn		= 1'b0 ;
	RdEn		= 1'b0 ;
	WrData      =  'b0 ;
	TX_DATA_V   = 1'b0 ;
	TX_P_DATA   =  'b0 ;
	clk_div_En  = 1'b1 ;
	Add_Store   = 1'b0 ;
	ALU_Store   = 1'b0 ;
	ALU_FUN_Store = 1'b0 ;
  ////////////////////////////////////////////////////////////////////// IDLE_STATE //////////////////////////////////////////////////////////////////////
    case (current_state)
      IDLE_state :
        begin
		  if (RX_D_VLD)
			begin
				case (RX_P_DATA)
					'hAA : next_state = RF_Wr_CMD ;
					'hBB : next_state = RF_Rd_CMD ;
					'hCC : next_state = ALU_OPER_W_OP_CMD ; 
					'hDD : next_state = ALU_OPER_W_NOP_CMD ; 
					default : next_state = IDLE_state ;
				endcase
		    end
		  else
			begin
			  next_state = IDLE_state ;
			end
		end
//////////////////////////////////////////////////////////////////////	RF_WRITE //////////////////////////////////////////////////////////////////////	
      RF_Wr_CMD :
        begin
		 // WrEn		= 1'b1 ;
          if (RX_D_VLD)
			begin
			  next_state = RF_Wr_Add ;	
		    end
		  else 
			begin
			  next_state = RF_Wr_CMD ;
			end
        end
      RF_Wr_Add :
        begin 
		  //WrEn		  = 1'b1 ;
		  Add_Store   = 1'b1 ;
		  Address     = RX_P_DATA[3:0] ;
          if (RX_D_VLD)
			begin
			  next_state = RF_Wr_Data ;
			  Add_Store   = 1'b0 ;	
		    end
		  else 
			begin
			  next_state = RF_Wr_Add ;
			  Add_Store   = 1'b1 ;
			end       
        end        
      RF_Wr_Data :
        begin 
		  WrEn		  = 1'b1 ;
		  WrData      = RX_P_DATA ;
		  Address     = Address_store ;
          next_state  = IDLE_state ;        
        end 
////////////////////////////////////////////////////////////////////// RF_READ //////////////////////////////////////////////////////////////////////		
      RF_Rd_CMD :
        begin
		 //RdEn		= 1'b1 ;	
         if (RX_D_VLD)
			begin
			  next_state = RF_Rd_Addr ;	
		    end
		  else 
			begin
			  next_state = RF_Rd_CMD ;
			end       
        end 
      RF_Rd_Addr :
        begin
		  RdEn		= 1'b1 ;
		  Address   = RX_P_DATA[3:0] ;
		  if (RdDATA_VLD && !FIFO_FULL)
			begin
			  next_state = FIFO_RF ;	
		    end
		  else 
			begin
			  next_state = RF_Rd_Addr ;
			end    
        end 
////////////////////////////////////////////////////////////////////// ALU_OP //////////////////////////////////////////////////////////////////////		
	  ALU_OPER_W_OP_CMD :
        begin	
		  ALU_EN		= 1'b1 ;
          if (RX_D_VLD)
			begin
			  next_state = Operand_A ;	
		    end
		  else 
			begin
			  next_state = ALU_OPER_W_OP_CMD ;
			end
        end	
	  Operand_A :
          begin 
		    ALU_EN		= 1'b1 ;
		    WrEn	    = 1'b1 ;
		    Address     = 'b0 ;
			WrData      = RX_P_DATA ;
            if (RX_D_VLD)
			  begin
			    next_state = Operand_B ;
				WrEn	    = 1'b0 ;				
		      end
		    else 
			  begin
			    next_state = Operand_A ;
		 	  end
          end
	  Operand_B :
          begin 
		    ALU_EN		= 1'b1 ;
		    WrEn	    = 1'b1 ;
		    Address     =  'b1 ;
			WrData      = RX_P_DATA ;
            if (RX_D_VLD)
		      begin
			    next_state = ALU_OPERATION ;
				WrEn	    = 1'b0 ;				
		      end
		    else 
			  begin
			    next_state = Operand_B ;
			  end
          end 
	  ALU_OPERATION :
          begin 
		    ALU_FUN		= RX_P_DATA[3:0] ;
			ALU_EN		= 1'b1 ;
			CLK_EN 		= 1'b1 ;
			ALU_FUN_Store = 1'b1 ;
			ALU_Store   = 1'b1 ;
			/*if (ALU_FUN == 'b1111)
			  begin
			    CLK_EN = 1'b0 ;
			  end
			else 
			  begin
			    CLK_EN = 1'b1 ;
			  end*/
		    if (ALU_OUT_VLD && !FIFO_FULL)
		      begin
		        next_state = FIFO_ALU ;	
				ALU_EN		= 1'b0 ;
		      end
		    else 
			  begin
			    next_state = ALU_OPERATION ;
			  end    
          end  
////////////////////////////////////////////////////////////////////// ALU_NOP //////////////////////////////////////////////////////////////////////		  
		ALU_OPER_W_NOP_CMD :
        begin 
		  ALU_EN		= 1'b1 ;
          if (RX_D_VLD)
			begin
			  next_state = ALU_OPERATION ;	
		    end
		  else 
			begin
			  next_state = ALU_OPER_W_NOP_CMD ;
			end
        end	  
////////////////////////////////////////////////////////////////////// FIFO //////////////////////////////////////////////////////////////////////		
		FIFO_RF :
          begin
		    RdEn	   = 1'b1 ;
			TX_DATA_V  = 1'b1 ;
			TX_P_DATA  = RdDATA ;
	        next_state = IDLE_state ;
	      end    
		FIFO_ALU :
          begin
		    ALU_FUN    = ALU_FUNC_Store ;
		    ALU_EN	   = 1'b1 ;
			TX_DATA_V  = 1'b1 ;
			TX_P_DATA  = ALU_FRAME_store[7:0] ;
	        next_state = ALU_SEC_FRAME ;
	      end	
		ALU_SEC_FRAME :
          begin
		    ALU_FUN    = ALU_FUNC_Store ;
		    ALU_EN	   = 1'b1 ;
			TX_DATA_V  = 1'b1 ;
			TX_P_DATA  = ALU_FRAME_store[15:8] ;
	        next_state = IDLE_state ;
	      end
		default : 
		  begin
		    next_state = IDLE_state ;
		  end 
    endcase
  end

always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        Address_store <= 'b0 ;
      end 
    else if (Add_Store)
      begin
        Address_store <= Address ;
      end   
  end
  
always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        ALU_FRAME_store <= 'b0 ;
      end 
    else if (ALU_Store)
      begin
        ALU_FRAME_store <= ALU_OUT ;
      end   
  end 
  
always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        ALU_FUNC_Store <= 'b0 ;
      end 
    else if (ALU_FUN_Store)
      begin
        ALU_FUNC_Store <= ALU_FUN ;
      end   
  end  
endmodule
