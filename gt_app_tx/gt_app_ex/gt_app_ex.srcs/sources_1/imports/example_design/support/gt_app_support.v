`timescale 1ns / 1ps
`define DLY #1

(* DowngradeIPIdentifiedWarnings="yes" *)
//***********************************Entity Declaration************************
(* CORE_GENERATION_INFO = "gt_app,gtwizard_v3_6_10,{protocol_file=Start_from_scratch}" *)
module gt_app_support # (
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP            = "TRUE",     // Simulation setting for GT SecureIP model
    parameter STABLE_CLOCK_PERIOD                    = 10         //Period of the stable clock driving this state-machine, unit is [ns]
) (
    input           soft_reset_tx_in            ,
    input           dont_reset_on_data_error_in ,
    input           q0_clk0_gtrefclk_pad_n_in   ,
    input           q0_clk0_gtrefclk_pad_p_in   ,
    output          gt0_tx_mmcm_lock_out        ,
    output          gt0_tx_fsm_reset_done_out   ,
    output          gt0_rx_fsm_reset_done_out   ,
    input           gt0_data_valid_in           ,
    output          gt0_txusrclk_out            ,
    output          gt0_txusrclk2_out           ,

    input   [8:0]   gt0_drpaddr_in              ,
    input   [15:0]  gt0_drpdi_in                ,
    output  [15:0]  gt0_drpdo_out               ,
    input           gt0_drpen_in                ,
    output          gt0_drprdy_out              ,
    input           gt0_drpwe_in                ,
    output  [7:0]   gt0_dmonitorout_out         ,
    input           gt0_eyescanreset_in         ,
    output          gt0_eyescandataerror_out    ,
    input           gt0_eyescantrigger_in       ,
    output  [6:0]   gt0_rxmonitorout_out        ,
    input   [1:0]   gt0_rxmonitorsel_in         ,
    input           gt0_gtrxreset_in            ,
    input           gt0_gttxreset_in            ,
    input           gt0_txuserrdy_in            ,
    input   [31:0]  gt0_txdata_in               ,
    output          gt0_gtxtxn_out              ,
    output          gt0_gtxtxp_out              ,
    output          gt0_txoutclkfabric_out      ,
    output          gt0_txoutclkpcs_out         ,
    output          gt0_txresetdone_out         ,
    input           gt0_txpolarity_in           ,

    output          gt0_qplllock_out            ,
    output          gt0_qpllrefclklost_out      ,
    output          gt0_qplloutclk_out          ,
    output          gt0_qplloutrefclk_out       ,
    input           sysclk_in
);


    wire    [8:0]   gt0_drpaddr_i           ;
    wire    [15:0]  gt0_drpdi_i             ;
    wire    [15:0]  gt0_drpdo_i             ;
    wire            gt0_drpen_i             ;
    wire            gt0_drprdy_i            ;
    wire            gt0_drpwe_i             ;
    wire    [7:0]   gt0_dmonitorout_i       ;
    wire            gt0_eyescanreset_i      ;
    wire            gt0_eyescandataerror_i  ;
    wire            gt0_eyescantrigger_i    ;
    wire    [6:0]   gt0_rxmonitorout_i      ;
    wire    [1:0]   gt0_rxmonitorsel_i      ;
    wire            gt0_gtrxreset_i         ;
    wire            gt0_gttxreset_i         ;
    wire            gt0_txuserrdy_i         ;
    wire    [31:0]  gt0_txdata_i            ;
    wire            gt0_gtxtxn_i            ;
    wire            gt0_gtxtxp_i            ;
    wire            gt0_txoutclk_i          ;
    wire            gt0_txoutclkfabric_i    ;
    wire            gt0_txoutclkpcs_i       ;
    wire            gt0_txresetdone_i       ;
    wire            gt0_txpolarity_i        ;

    wire            gt0_qplllock_i          ;
    wire            gt0_qpllrefclklost_i    ;
    wire            gt0_qpllreset_i         ;
    wire            gt0_qpllreset_t         ;
    wire            gt0_qplloutclk_i        ;
    wire            gt0_qplloutrefclk_i     ;

    wire            sysclk_in_i             ;
    wire            gt0_tx_system_reset_c   ;
    wire            gt0_rx_system_reset_c   ;
    wire            GTTXRESET_IN            ;
    wire            GTRXRESET_IN            ;
    wire            QPLLRESET_IN            ;

    wire            gt0_txusrclk_i          ; 
    wire            gt0_txusrclk2_i         ; 
    wire            gt0_rxusrclk_i          ; 
    wire            gt0_rxusrclk2_i         ; 
    wire            gt0_txmmcm_lock_i       ;
    wire            gt0_txmmcm_reset_i      ;

    wire            q0_clk0_refclk_i        ;

    wire            commonreset_i           ;
    wire            commonreset_t           ;


    assign gt0_tx_mmcm_lock_out     = gt0_txmmcm_lock_i;
 
    assign gt0_qplllock_out         = gt0_qplllock_i;
    assign gt0_qpllrefclklost_out   = gt0_qpllrefclklost_i;
    assign gt0_qpllreset_t          = commonreset_i | gt0_qpllreset_i;
     
    assign gt0_qplloutclk_out       = gt0_qplloutclk_i;
    assign gt0_qplloutrefclk_out    = gt0_qplloutrefclk_i;
 
    assign gt0_txusrclk_out         = gt0_txusrclk_i; 
    assign gt0_txusrclk2_out        = gt0_txusrclk2_i;

    assign  sysclk_in_i             = sysclk_in;


    gt_app_GT_USRCLK_SOURCE gt_usrclk_source (
        .Q0_CLK0_GTREFCLK_PAD_P_IN  (q0_clk0_gtrefclk_pad_p_in  ),
        .Q0_CLK0_GTREFCLK_PAD_N_IN  (q0_clk0_gtrefclk_pad_n_in  ),
        .GT0_TXOUTCLK_IN            (gt0_txoutclk_i             ),
        .GT0_TX_MMCM_RESET_IN       (gt0_txmmcm_reset_i         ),
        .GT0_TXUSRCLK_OUT           (gt0_txusrclk_i             ),
        .GT0_TXUSRCLK2_OUT          (gt0_txusrclk2_i            ),
        .GT0_TXCLK_LOCK_OUT         (gt0_txmmcm_lock_i          ),
        .Q0_CLK0_GTREFCLK_OUT       (q0_clk0_refclk_i           )
    );

    gt_app_common_reset #  (
        .STABLE_CLOCK_PERIOD        (STABLE_CLOCK_PERIOD        )  // Period of the stable clock driving this state-machine, unit is [ns]
    ) common_reset_i (      
        .STABLE_CLOCK               (sysclk_in_i                ),  //Stable Clock, either a stable clock from the PCB
        .SOFT_RESET                 (soft_reset_tx_in           ),  //User Reset, can be pulled any time
        .COMMON_RESET               (commonreset_i              )   //output Reset QPLL
    );

    gt_app_common # (
        .WRAPPER_SIM_GTRESET_SPEEDUP(EXAMPLE_SIM_GTRESET_SPEEDUP),
        .SIM_QPLLREFCLK_SEL         (3'b001                     )
    ) common0_i (
        .QPLLREFCLKSEL_IN           (3'b001                     ),
        .GTREFCLK0_IN               (q0_clk0_refclk_i           ),
        .GTREFCLK1_IN               (1'b0                       ),
        .QPLLLOCKDETCLK_IN          (sysclk_in_i                ),
        .QPLLLOCK_OUT               (gt0_qplllock_i             ),
        .QPLLOUTCLK_OUT             (gt0_qplloutclk_i           ),
        .QPLLOUTREFCLK_OUT          (gt0_qplloutrefclk_i        ),
        .QPLLREFCLKLOST_OUT         (gt0_qpllrefclklost_i       ),
        .QPLLRESET_IN               (gt0_qpllreset_t            )
    );


    gt_app gt_app_init_i
    (
        .sysclk_in                      (sysclk_in_i                ),
        .soft_reset_tx_in               (soft_reset_tx_in           ),
        .dont_reset_on_data_error_in    (dont_reset_on_data_error_in),
        .gt0_tx_mmcm_lock_in            (gt0_txmmcm_lock_i          ),
        .gt0_tx_mmcm_reset_out          (gt0_txmmcm_reset_i         ),
        .gt0_tx_fsm_reset_done_out      (gt0_tx_fsm_reset_done_out  ),
        .gt0_rx_fsm_reset_done_out      (gt0_rx_fsm_reset_done_out  ),
        .gt0_data_valid_in              (gt0_data_valid_in          ),

        .gt0_drpaddr_in                 (gt0_drpaddr_in             ), // input wire [8:0] gt0_drpaddr_in
        .gt0_drpclk_in                  (sysclk_in_i                ), // input wire sysclk_in_i
        .gt0_drpdi_in                   (gt0_drpdi_in               ), // input wire [15:0] gt0_drpdi_in
        .gt0_drpdo_out                  (gt0_drpdo_out              ), // output wire [15:0] gt0_drpdo_out
        .gt0_drpen_in                   (gt0_drpen_in               ), // input wire gt0_drpen_in
        .gt0_drprdy_out                 (gt0_drprdy_out             ), // output wire gt0_drprdy_out
        .gt0_drpwe_in                   (gt0_drpwe_in               ), // input wire gt0_drpwe_in
        .gt0_dmonitorout_out            (gt0_dmonitorout_out        ), // output wire [7:0] gt0_dmonitorout_out
        .gt0_eyescanreset_in            (gt0_eyescanreset_in        ), // input wire gt0_eyescanreset_in
        .gt0_eyescandataerror_out       (gt0_eyescandataerror_out   ), // output wire gt0_eyescandataerror_out
        .gt0_eyescantrigger_in          (gt0_eyescantrigger_in      ), // input wire gt0_eyescantrigger_in
        .gt0_rxmonitorout_out           (gt0_rxmonitorout_out       ), // output wire [6:0] gt0_rxmonitorout_out
        .gt0_rxmonitorsel_in            (gt0_rxmonitorsel_in        ), // input wire [1:0] gt0_rxmonitorsel_in
        .gt0_gtrxreset_in               (gt0_gtrxreset_in           ), // input wire gt0_gtrxreset_in
        .gt0_gttxreset_in               (gt0_gttxreset_in           ), // input wire gt0_gttxreset_in
        .gt0_txuserrdy_in               (gt0_txuserrdy_in           ), // input wire gt0_txuserrdy_in
        .gt0_txusrclk_in                (gt0_txusrclk_i             ), // input wire gt0_txusrclk_i
        .gt0_txusrclk2_in               (gt0_txusrclk2_i            ), // input wire gt0_txusrclk2_i
        .gt0_txdata_in                  (gt0_txdata_in              ), // input wire [31:0] gt0_txdata_in
        .gt0_gtxtxn_out                 (gt0_gtxtxn_out             ), // output wire gt0_gtxtxn_out
        .gt0_gtxtxp_out                 (gt0_gtxtxp_out             ), // output wire gt0_gtxtxp_out
        .gt0_txoutclk_out               (gt0_txoutclk_i             ), // output wire gt0_txoutclk_i
        .gt0_txoutclkfabric_out         (gt0_txoutclkfabric_out     ), // output wire gt0_txoutclkfabric_out
        .gt0_txoutclkpcs_out            (gt0_txoutclkpcs_out        ), // output wire gt0_txoutclkpcs_out
        .gt0_txresetdone_out            (gt0_txresetdone_out        ), // output wire gt0_txresetdone_out
        .gt0_txpolarity_in              (gt0_txpolarity_in          ), // input wire gt0_txpolarity_in

        .gt0_qplllock_in                (gt0_qplllock_i             ),
        .gt0_qpllrefclklost_in          (gt0_qpllrefclklost_i       ),
        .gt0_qpllreset_out              (gt0_qpllreset_i            ),
        .gt0_qplloutclk_in              (gt0_qplloutclk_i           ),
        .gt0_qplloutrefclk_in           (gt0_qplloutrefclk_i        )
    );



 
endmodule
    


