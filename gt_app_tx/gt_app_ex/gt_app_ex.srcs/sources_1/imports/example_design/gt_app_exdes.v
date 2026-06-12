`timescale 1ns / 1ps
`define DLY #1

(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
(* CORE_GENERATION_INFO = "gt_app,gtwizard_v3_6_10,{protocol_file=Start_from_scratch}" *)
module gt_app_exdes # (
    parameter       EXAMPLE_CONFIG_INDEPENDENT_LANES     =   1            ,   // configuration for frame gen and check
    parameter       EXAMPLE_LANE_WITH_START_CHAR         =   0            ,   // specifies lane with unique start frame char
    parameter       EXAMPLE_WORDS_IN_BRAM                =   512          ,   // specifies amount of data in BRAM
    parameter       EXAMPLE_SIM_GTRESET_SPEEDUP          =   "TRUE"       ,   // simulation setting for GT SecureIP model
    parameter       EXAMPLE_USE_CHIPSCOPE                =   0            ,   // Set to 1 to use Chipscope to drive resets
    parameter       STABLE_CLOCK_PERIOD                  =   10
) (
    input  wire     DRPCLK_IN                   ,
    input  wire     Q0_CLK0_GTREFCLK_PAD_N_IN   ,
    input  wire     Q0_CLK0_GTREFCLK_PAD_P_IN   ,
    output wire     TXN_OUT                     ,
    output wire     TXP_OUT
);

    wire    [7:0]   gt0_dmonitorout_i       ;
    wire            gt0_eyescandataerror_i  ;
    wire    [6:0]   gt0_rxmonitorout_i      ;
    wire    [1:0]   gt0_rxmonitorsel_i      ;
    wire            gt0_gttxreset_i         ;
    wire            gt0_txuserrdy_i         ;
    wire    [31:0]  gt0_txdata_i            ;
    wire            gt0_gtxtxn_i            ;
    wire            gt0_gtxtxp_i            ;
    wire            gt0_txoutclk_i          ;
    wire            gt0_txoutclkfabric_i    ;
    wire            gt0_txoutclkpcs_i       ;
    wire            gt0_txresetdone_i       ;

    wire            gt0_tx_system_reset_c   ;

    wire            gt0_txusrclk_i          ; 
    wire            gt0_txusrclk2_i         ; 
    wire            gt0_txmmcm_lock_i       ;

    wire    [15:0]  gt0_txdata_float16_i    ;
    wire    [31:0]  gt0_txdata_float_i      ;
  
    gt_app_support # (
        .EXAMPLE_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP),
        .STABLE_CLOCK_PERIOD            (STABLE_CLOCK_PERIOD        )
    ) gt_app_support_i (        
        .soft_reset_tx_in               (1'b0                       ),
        .dont_reset_on_data_error_in    (1'b0                       ),
        .q0_clk0_gtrefclk_pad_n_in      (Q0_CLK0_GTREFCLK_PAD_N_IN  ),
        .q0_clk0_gtrefclk_pad_p_in      (Q0_CLK0_GTREFCLK_PAD_P_IN  ),
        .gt0_tx_mmcm_lock_out           (gt0_txmmcm_lock_i          ),
        .gt0_tx_fsm_reset_done_out      (gt0_txfsmresetdone_i       ),
        .gt0_rx_fsm_reset_done_out      (gt0_rxfsmresetdone_i       ),
        .gt0_data_valid_in              (1'b0                       ),
 
        .gt0_txusrclk_out               (gt0_txusrclk_i             ),
        .gt0_txusrclk2_out              (gt0_txusrclk2_i            ),

        .gt0_drpaddr_in                 (9'd0                       ), 
        .gt0_drpdi_in                   (16'd0                      ),
        .gt0_drpdo_out                  (                           ),
        .gt0_drpen_in                   (1'b0                       ),
        .gt0_drprdy_out                 (                           ),
        .gt0_drpwe_in                   (1'b0                       ),
        .gt0_dmonitorout_out            (gt0_dmonitorout_i          ),
        .gt0_eyescanreset_in            (1'b0                       ),
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_i     ),
        .gt0_eyescantrigger_in          (1'b0                       ),
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_i         ),
        .gt0_rxmonitorsel_in            (2'b00                      ),
        .gt0_gtrxreset_in               (1'b0                       ),
        .gt0_gttxreset_in               (1'b0                       ),
        .gt0_txuserrdy_in               (1'b1                       ),
        .gt0_txdata_in                  (gt0_txdata_i               ),
        .gt0_gtxtxn_out                 (TXN_OUT                    ),
        .gt0_gtxtxp_out                 (TXP_OUT                    ),
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_i       ),
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_i          ),
        .gt0_txresetdone_out            (gt0_txresetdone_i          ),
        .gt0_txpolarity_in              (1'b0                       ),

        .gt0_qplllock_out               (                           ),
        .gt0_qpllrefclklost_out         (                           ),
        .gt0_qplloutclk_out             (                           ),
        .gt0_qplloutrefclk_out          (                           ),
        .sysclk_in                      (DRPCLK_IN                  )
    );
    
    always @(posedge  gt0_txusrclk2_i or negedge gt0_txfsmresetdone_i) begin
        if (!gt0_txfsmresetdone_i) begin
            gt0_txfsmresetdone_r    <=   `DLY 1'b0;
            gt0_txfsmresetdone_r2   <=   `DLY 1'b0;
        end
        else begin
            gt0_txfsmresetdone_r    <=   `DLY gt0_txfsmresetdone_i;
            gt0_txfsmresetdone_r2   <=   `DLY gt0_txfsmresetdone_r;
        end
    end

    gt_app_GT_FRAME_GEN # (
        .WORDS_IN_BRAM(EXAMPLE_WORDS_IN_BRAM                                    )
    ) gt0_frame_gen (
        .TX_DATA_OUT  ({gt0_txdata_float_i,gt0_txdata_i,gt0_txdata_float16_i}   ),
        .TXCTRL_OUT   (                                                         ),
        .USER_CLK     (gt0_txusrclk2_i                                          ),
        .SYSTEM_RESET (gt0_tx_system_reset_c                                    )
    );


    assign gt0_tx_system_reset_c = !gt0_txfsmresetdone_r2;



endmodule
    

