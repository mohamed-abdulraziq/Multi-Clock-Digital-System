`timescale 1ns/1ps 
module SYSTEM_TB #(parameter REF_Clock_Period = 10, UART_Clock_Period = 271.267, DATA_WIDTH = 8, DEPTH = 16, ADDR = 4)
();
/////////////////////////////////////////////////////////////////////////////////////
reg         	 	     REF_CLK_TB;
reg           		  	 UART_CLK_TB;
reg                	     RST_TB;
reg         		     RX_IN_TB;
wire                     parity_error_TB;
wire                     framing_error_TB;
wire  				     TX_OUT_TB;
/////////////////////////////////////////////////////////////////////////////////////
SYSTEM_TOP DUT 
(
.REF_CLK(REF_CLK_TB),
.UART_CLK(UART_CLK_TB),
.RST(RST_TB),
.RX_IN(RX_IN_TB),
.parity_error(parity_error_TB),
.framing_error(framing_error_TB),
.TX_OUT(TX_OUT_TB)
);
/////////////////////////////////////////////////////////////////////////////////////
parameter TX_Clock_Period = 8680.5 ;
reg       TX_Clock ;
reg  [10:0]     Frame;
/////////////////////////////////////////////////////////////////////////////////////
always #(REF_Clock_Period/2) REF_CLK_TB = ~REF_CLK_TB ;

always #(TX_Clock_Period/2.0) TX_Clock = ~TX_Clock ;

always #(UART_Clock_Period/2.0) UART_CLK_TB = ~UART_CLK_TB ;
/////////////////////////////////////////////////////////////////////////////////////
task INITIALIZE ;
  begin
    RST_TB        = 1'b1 ;
	TX_Clock      = 1'b0 ;
    REF_CLK_TB    = 1'b0 ;
    UART_CLK_TB   = 1'b0 ;
    RX_IN_TB      = 1'b1 ;
  end 
endtask
/////////////////////////////////////////////////////////////////////////////////////  
task reset ;
 begin
  #(UART_Clock_Period)
  RST_TB  = 1'b0;           // rst is activated
  #(UART_Clock_Period)
  RST_TB  = 1'b1;
  #(UART_Clock_Period) ;
 end
endtask
/////////////////////////////////////////////////////////////////////////////////////
task DATA_IN ;
 input  [DATA_WIDTH-1:0]  DATA ;
 input                    PAR_En_Tb ;
 input                    PAR_TYP_Tb ;
 integer   i  ;
 
 begin
	@(posedge TX_Clock)  
	RX_IN_TB <= 1'b0 ;              // start_bit

	for(i=0; i<8; i=i+1)
		begin
		@(posedge TX_Clock) 		
		RX_IN_TB <= DATA[i] ;       // data bits
		end 

	if(PAR_En_Tb)
		begin
			@(posedge TX_Clock) 
			case(PAR_TYP_Tb)
			1'b0 : RX_IN_TB <= ^DATA  ;     // Even Parity
			1'b1 : RX_IN_TB <= ~^DATA ;     // Odd Parity
			endcase	
		end
	@(posedge TX_Clock) 
	RX_IN_TB <= 1'b1 ;              // stop_bit
	
 end
endtask
/////////////////////////////////////////////////////////////////////////////////////
task save_outputs ;
  input is_parity_En;
  integer i;
  integer iterations;
  begin
    iterations = 10;
    if (is_parity_En) 
      begin
        iterations = 11;
      end
	@(posedge TX_Clock)
    #(2*TX_Clock_Period)
      Frame[10] = 0;

  for (i = 2; i < iterations; i = i + 1) 
    begin
      @(posedge TX_Clock) Frame[i] = TX_OUT_TB;
    end
   
  if (is_parity_En) 
    begin
      @(posedge TX_Clock) Frame[1] = 0;
      @(posedge TX_Clock) Frame[0] = 1;
    end
  else 
    begin
      @(posedge TX_Clock) Frame[1] = 1;
    end
  end
endtask
/////////////////////////////////////////////////////////////////////////////////////
task Check_Output_Data ;
  input           [10:0]     Expec_Out ;
  begin
		#(TX_Clock_Period);
	     if(Frame == Expec_Out) 
		     begin
			     $display("Test Case is succeeded Expec_Out = %b and Actual_Out = %b at time = %0t", Expec_Out, Frame, $time);
		     end
	     else
		     begin
			     $display("Test Case is failed Expec_Out = %b and Actual_Out = %b at time = %0t", Expec_Out, Frame, $time);
		     end 
  end			 
endtask			 
/////////////////////////////////////////////////////////////////////////////////////
task Check_Output_Data_16scale ;
  input           [10:0]     Expec_Out ;
  begin
         //#(5*TX_Clock_Period);
	     if(Frame == Expec_Out) 
		     begin
			     $display("Test Case is succeeded Expec_Out = %b and Actual_Out = %b at time = %0t", Expec_Out, Frame, $time);
		     end
	     else
		     begin
			     $display("Test Case is failed Expec_Out = %b and Actual_Out = %b at time = %0t", Expec_Out, Frame, $time);
		     end 
  end			 
endtask			 
/////////////////////////////////////////////////////////////////////////////////////

initial
  begin
    $dumpfile("SYSTEM_TOP.vcd") ;       
    $dumpvars;
    //////////////////////////////////////     
    INITIALIZE() ;
    //////////////////////////////////////   
    reset() ;
	////////////////////////////////////// Writting case /////////////////////////////////
	DATA_IN('hAA, 1,0);
	#(TX_Clock_Period);
	DATA_IN('hFA, 1,0);
    #(TX_Clock_Period);
	DATA_IN('hCC, 1,0);
	////////////////////////////////////// Reading case /////////////////////////////////
	DATA_IN('hBB, 1,0);
	#(TX_Clock_Period);
	DATA_IN('hFA, 1,0);
	save_outputs(1);
	Check_Output_Data('b01100110001);
	#(TX_Clock_Period);
	#(TX_Clock_Period);
	////////////////////////////////////// ALU_NOP case /////////////////////////////////
    DATA_IN('hDD, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h02, 1,0);///////ALU FUN (Multiplication)
	#(TX_Clock_Period);
	save_outputs(1);
	Check_Output_Data('b00010100001);
	////////////////////////////////////// ALU_OP case /////////////////////////////////
	#(TX_Clock_Period);
	DATA_IN('hCC, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h10, 1,0);///////OP A
    #(TX_Clock_Period);
	DATA_IN('h06, 1,0);///////OP B
	#(TX_Clock_Period);
	DATA_IN('h01, 1,0);///////ALU FUN (subtraction)
	#(TX_Clock_Period);
	save_outputs(1);
	Check_Output_Data('b00000101001);
	#(TX_Clock_Period);
	//////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////// change config case /////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////
	DATA_IN('hAA, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h02, 1,0);
    #(TX_Clock_Period);
	DATA_IN('b010000_01, 1,0);
	#(TX_Clock_Period);
	/*DATA_IN('hAA, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h03, 1,0);            ////////////////////  Division ratio for TX changing is not in the specs 
    #(TX_Clock_Period);
	DATA_IN('b00010000, 1,0);
	#(TX_Clock_Period);*/
	////////////////////////////////////// Writting case /////////////////////////////////
	DATA_IN('hAA, 1,0);
	#(TX_Clock_Period);
	DATA_IN('hFB, 1,0);
    #(TX_Clock_Period);
	DATA_IN('hFF, 1,0);
	////////////////////////////////////// Reading case /////////////////////////////////
	DATA_IN('hBB, 1,0);
	#(TX_Clock_Period);
	DATA_IN('hFB, 1,0);
	save_outputs(1);
	Check_Output_Data('b01111111101);
	#(TX_Clock_Period);
	#(TX_Clock_Period);
	////////////////////////////////////// ALU_NOP case /////////////////////////////////
    DATA_IN('hDD, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h02, 1,0);///////ALU FUN (Multiplication) 16*6=96
	#(TX_Clock_Period);
	save_outputs(1);
	Check_Output_Data('b00110000001);
	////////////////////////////////////// ALU_OP case /////////////////////////////////
	#(TX_Clock_Period);
	DATA_IN('hCC, 1,0);
	#(TX_Clock_Period);
	DATA_IN('h10, 1,0);///////OP A
    #(TX_Clock_Period);
	DATA_IN('h04, 1,0);///////OP B
	#(TX_Clock_Period);
	DATA_IN('h01, 1,0);///////ALU FUN (subtraction)   16 - 4 = 12
	#(TX_Clock_Period);
	save_outputs(1);
	Check_Output_Data_16scale('b00000110001);
	#(100*TX_Clock_Period);
	$stop;
	
  end

endmodule