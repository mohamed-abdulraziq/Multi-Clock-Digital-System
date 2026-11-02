module uart_rx_FSM_mohamed_abdulrazeq  
(
input    wire         clk_F,
input    wire         rst_F,
input    wire         Ser_Data_F,
input    wire         PAR_En_F,
input    wire  [5:0]  Prescale_F,
input    wire  [3:0]  bits_cnt_F,
input    wire  [5:0]  Cnt_edge_F,
input    wire         PAR_err_F,
input    wire         strt_err_F,
input    wire         stp_err_F,
output   reg          D_samp_En_F,
output   reg          CUN_Zero_F,
output   reg          cnt_En_F,
output   reg          Desser_En_F,
output   reg          PAR_chk_En_F,
output   reg          strt_chk_En_F,
output   reg          stp_chk_En_F,
output   reg          DATA_Valid_F
);

reg           Data_Valid_f ;
wire          Cnt_edge_FLAG ;
assign Cnt_edge_FLAG = Cnt_edge_F == (Prescale_F - 1) ;

/////// gray STATES Encoding  ///////  
   
typedef enum bit [2:0]{
                       Start_State              = 3'b000 ,
                       IDLE_state               = 3'b001 ,
                       Parity_State             = 3'b011 ,
                       Stop_State               = 3'b010 ,
                       check_out_State          = 3'b110 ,
                       Data_State               = 3'b111 
} State_e ;

State_e    current_state , next_state ;


/////// STATES Transition  ///////      
                    
always@(posedge clk_F or negedge rst_F)
  begin
    if (!rst_F)
      begin
        current_state <= IDLE_state ;
      end 
    else
      begin
        current_state <= next_state ;
      end   
  end

 /////// Next STATES && OUTPUT LOGIC ///////

always@(*)
  begin 
      cnt_En_F      = 1'b0 ;
	  CUN_Zero_F    = 1'b0 ;
	  Desser_En_F   = 1'b0 ;
	  D_samp_En_F   = 1'b0 ;
	  PAR_chk_En_F  = 1'b0 ;
	  strt_chk_En_F = 1'b0 ;
	  stp_chk_En_F  = 1'b0 ;
	  DATA_Valid_F  = 1'b0 ;
    case (current_state)
	  IDLE_state :  
	    begin
		  CUN_Zero_F    = 1'b1 ;
	      if (!Ser_Data_F)
		    begin
			  next_state = Start_State ; 
			end
	      else 
		    begin
			  next_state = IDLE_state ;
			end
		end  
	      
	  Start_State :
		begin
		  cnt_En_F      = 1'b1 ;
		  D_samp_En_F   = 1'b1 ;
		  strt_chk_En_F = 1'b1 ;
		  if (Cnt_edge_FLAG && !strt_err_F)
			begin 
			  next_state = Data_State ; 
			end
		  else if (strt_err_F)
			begin
			  next_state = IDLE_state ;
			end
		  else 
			begin 
			  next_state = Start_State ;
			end  
		end
	  Data_State :
		begin
		  cnt_En_F    = 1'b1 ;
		  Desser_En_F = 1'b1 ;
		  D_samp_En_F = 1'b1 ;
		  if (bits_cnt_F == 4'd8 && Cnt_edge_FLAG && PAR_En_F)
			begin
			  next_state = Parity_State ; 
			end
		  else if (bits_cnt_F == 4'd8 && Cnt_edge_FLAG && !PAR_En_F)	
			begin
			  next_state = Stop_State ; 
			end
		  else
			begin
			  next_state = Data_State ; 
			end
		end
	  Parity_State : 
        begin 
          cnt_En_F     = 1'b1 ;
		  D_samp_En_F  = 1'b1 ;
	      PAR_chk_En_F = 1'b1 ;
		  if (!PAR_err_F && Cnt_edge_FLAG)
		    begin
			  next_state = Stop_State ; 
			end 
		  else if (PAR_err_F && Cnt_edge_FLAG)
		    begin
			  next_state = IDLE_state ; 
			end 
		  else 
			begin
	          next_state = Parity_State ; 
			end
		end	
	  Stop_State :
		begin 
		  cnt_En_F     = 1'b1 ;
		  D_samp_En_F  = 1'b1 ;
	      stp_chk_En_F = 1'b1 ;
		  if (!stp_err_F && Cnt_edge_F == ((Prescale_F - 2)))
		    begin
			  next_state = check_out_State ; 
			end 
		  else if (stp_err_F && Cnt_edge_F == ((Prescale_F - 2)))
		    begin
			  next_state = IDLE_state ; 
			end 
		  else 
			begin
	          next_state = Stop_State ; 
			end
		end
	  check_out_State :
		begin
		  DATA_Valid_F = 1'b1 ;
		  if (!Ser_Data_F)
		    begin
			  next_state = Start_State ; 
			end
		  else if (Ser_Data_F) 
		    begin
			  next_state = IDLE_state ; 
			end
		  else 
			begin
	          next_state = check_out_State ; 
			end	
		end
	  default : next_state = IDLE_state ; 	
	endcase
  end
 endmodule
 
  
  