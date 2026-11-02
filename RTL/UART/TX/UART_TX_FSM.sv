module UART_TX_FSM_mohamed_abdulrazeq (
input   wire           clk_F,                      
input   wire           rst_F,      
input   wire           PAR_En_F,
input   wire           Data_Valid_F,
input   wire           Ser_Done_F,
output  reg            Busy_F,
output  reg            Ser_En_F,
output  reg            Count_En_F,
output  reg   [1:0]    Mux_Sel_F
);

 /////// gray STATES Encoding  ///////  
   
typedef enum bit [2:0]{
                       IDLE_state              = 3'b000 ,
                       Start_bit_State         = 3'b001 ,
                       Data_State              = 3'b011 ,
                       Parity_State            = 3'b010 ,
                       Stop_bit_State          = 3'b110 
} State_e ;

State_e    current_state , next_state ;
/*

localparam IDLE_state         = 3'b000 ;
localparam Start_bit_State    = 3'b000 ;
localparam Data_State    	  = 3'b000 ;
localparam Parity_State    	  = 3'b000 ;
localparam Stop_bit_State 	  = 3'b000 ;
reg [2:0]  current_state ;
reg [2:0]  next_state ;
*/

reg                    busy_c ;

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

 /////// Next STATES ///////

always@(*)
  begin
    case (current_state)
      IDLE_state :
        begin
          if (Data_Valid_F)
            begin
              next_state = Start_bit_State ; 
            end
          else 
            begin 
              next_state = IDLE_state ;   
            end    
        end
      Start_bit_State :
        begin 
          next_state = Data_State ;       
        end
      Data_State :
        begin 
          if (PAR_En_F && Ser_Done_F)
            begin 
              next_state = Parity_State ;
            end
          else if (!PAR_En_F && Ser_Done_F)  
            begin
              next_state = Stop_bit_State ;
            end
          else 
            begin 
              next_state = Data_State ; 
            end        
        end 
      Parity_State :
        begin 
          next_state = Stop_bit_State ;       
        end 
      Stop_bit_State :
        begin     
          next_state = IDLE_state ;       
        end     
    endcase
  end
    
 ///////  OUTPUT logic  ///////    
     
always@(*)
  begin
    Busy_F = 1'b0 ;
    Mux_Sel_F = 2'b01 ;       //// High at IDLE ----------> Stop_bit 
    Ser_En_F = 1'b0 ;
    Count_En_F = 1'b0 ;  
    case (current_state)
      IDLE_state :
        begin   
        end
      Start_bit_State :
        begin 
          Busy_F = 1'b1 ;
          Mux_Sel_F = 2'b00 ;
          Ser_En_F = 1'b1 ; 
          Count_En_F = 1'b1 ;       
        end
      Data_State :
        begin 
          Busy_F = 1'b1 ;
          Mux_Sel_F = 2'b10 ;
          Count_En_F = rst_F ;
          Ser_En_F = 1'b1 ;
        end
      Parity_State :
        begin 
          Busy_F = 1'b1 ;
          Mux_Sel_F = 2'b11 ; 
          Count_En_F = 1'b0 ;      
        end
      Stop_bit_State :
        begin 
          Busy_F = 1'b1 ;
          Mux_Sel_F = 2'b01 ;      
        end
    endcase
  end
  
 /*always @ (posedge clk_F or negedge rst_F)
 begin
  if(!rst_F)
   begin
    Busy_F <= 1'b0 ;
   end
  else
   begin
    Busy_F <= busy_c ;
   end
 end*/
 
endmodule
