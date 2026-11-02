module uart_rx_TOP_mohamed_abdulrazeq
(
input  wire          clk,
input  wire          rst,
input  wire          RX_IN,
input  wire  [5:0]   Prescale,
input  wire          PAR_En,
input  wire          PAR_TYP,
output wire  [7:0]   P_Data,
output wire          Parity_Err,
output wire          Data_Valid,       
output wire          Stop_Err
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

wire         [5:0]   edge_cnt ;
wire         [3:0]   bits_cnt ;
wire                 D_samp_En ;
wire                 CUN_Zero ;
wire                 cnt_En ;
wire         [7:0]   P_Data_in ;
wire                 Desser_En ;
wire                 PAR_chk_En ;
wire                 strt_chk_En ;
wire                 stp_chk_En ;
wire                 Strt_Err;
wire         [2:0]   Sampled ;
wire         [2:0]   samples ;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_FSM_mohamed_abdulrazeq FSM                                                                                              
(.clk_F              (clk),
 .rst_F              (rst),
 .PAR_En_F           (PAR_En),                
 .Prescale_F         (Prescale),
 .Cnt_edge_F         (edge_cnt),
 .DATA_Valid_F       (Data_Valid),
 .Ser_Data_F         (RX_IN),
 .bits_cnt_F         (bits_cnt),
 .PAR_err_F          (Parity_Err),
 .strt_err_F         (Strt_Err),
 .D_samp_En_F        (D_samp_En),
 .cnt_En_F           (cnt_En),
 .CUN_Zero_F         (CUN_Zero),
 .Desser_En_F        (Desser_En),
 .PAR_chk_En_F       (PAR_chk_En),
 .strt_chk_En_F      (strt_chk_En),
 .stp_chk_En_F       (stp_chk_En),
 .stp_err_F          (Stop_Err)
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_DATA_SAMPLIE_mohamed_abdulrazeq SAMPLING
(.clk_DA             (clk),
 .rst_DA             (rst),
 .Prescale_DA        (Prescale),
 .edge_cnt_DA        (edge_cnt),
 .Ser_Data_DA        (RX_IN),
 .Data_Samp_En_DA    (D_samp_En),
 .samples_DA         (samples),
 .Sampled_DA         (Sampled)
);
 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_DESERIALIZE_mohamed_abdulrazeq DESERIALIZER
(.clk_DS             (clk),
 .rst_DS             (rst),
 .P_Data_DS          (P_Data),
 .P_Data_in_DS       (P_Data_in),
 .Cnt_bit_DS         (bits_cnt),
 .DATA_Valid_DS      (Data_Valid),
 .Desser_En_DS       (Desser_En),
 .Cnt_edge_DS        (edge_cnt),
 .Prescale_DS        (Prescale),
 .Sampled_DS         (Sampled)
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_COUNTER_mohamed_abdulrazeq COUNTER
(.clk_c              (clk),
 .rst_c              (rst),
 .Cnt_En_c           (cnt_En),
 .Prescale_c         (Prescale),
 .PAR_En_c           (PAR_En),
 .CUN_Zero_c         (CUN_Zero),
 .Cnt_edge_c         (edge_cnt),
 .Cnt_bit_c          (bits_cnt)
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_START_CHECK_mohamed_abdulrazeq START_CHECK
(.srt_chk_En_ST      (strt_chk_En),
 .Sampled_ST         (Sampled),
 .Cnt_edge_ST        (edge_cnt),
 .Prescale_ST        (Prescale),
 .srt_err_ST         (Strt_Err)
);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_STP_CHK_mohamed_abdulrazeq STOP_CHECK
(.clk_S              (clk),
 .rst_S              (rst),
 .Cnt_edge_S         (edge_cnt),
 .Prescale_S         (Prescale),
 .stp_chk_En_S       (stp_chk_En),
 .Sampled_S          (Sampled),
 .samples_S          (samples),
 .stp_err_S          (Stop_Err)
);   

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

uart_rx_PAR_CHK_mohamed_abdulrazeq PARITY_CHECK
(.clk_P              (clk),
 .rst_P              (rst),
 .PAR_TYP_P          (PAR_TYP),
 .PAR_chk_En_P       (PAR_chk_En),
 .P_Data_in_P        (P_Data_in),
 .Sampled_P          (Sampled), 
 .Cnt_edge_P         (edge_cnt),
 .Prescale_P         (Prescale),
 .PAR_err_P          (Parity_Err)
);         
endmodule