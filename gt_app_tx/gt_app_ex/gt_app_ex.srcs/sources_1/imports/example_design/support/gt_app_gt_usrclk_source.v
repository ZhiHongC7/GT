`timescale 1ns / 1ps
`define DLY #1


//***********************************Entity Declaration*******************************

module gt_app_GT_USRCLK_SOURCE (
    input  wire     Q0_CLK0_GTREFCLK_PAD_N_IN   ,
    input  wire     Q0_CLK0_GTREFCLK_PAD_P_IN   ,
    input           GT0_TXOUTCLK_IN             ,
    input           GT0_TX_MMCM_RESET_IN        ,
    output          GT0_TXUSRCLK_OUT            ,
    output          GT0_TXUSRCLK2_OUT           ,
    output          GT0_TXCLK_LOCK_OUT          ,
    output wire     Q0_CLK0_GTREFCLK_OUT
);


    wire            q0_clk0_gtrefclk /*synthesis syn_noclockbuf=1*/;
    wire            gt0_txoutclk_i          ;
    wire            gt0_txusrclk_i          ;
    wire            txoutclk_mmcm0_locked_i ;
    wire            txoutclk_mmcm0_reset_i  ;
    wire            gt0_txoutclk_to_mmcm_i  ;


//*********************************** Beginning of Code *******************************

    // 
    IBUFDS_GTE2 ibufds_instQ0_CLK0 (
        .O               (q0_clk0_gtrefclk          ),
        .ODIV2           (                          ),
        .CEB             (1'b0                      ),  // 低有效
        .I               (Q0_CLK0_GTREFCLK_PAD_P_IN ),
        .IB              (Q0_CLK0_GTREFCLK_PAD_N_IN )
    );

    gt_app_CLOCK_MODULE # (
        .MULT            (4.0                       ),
        .DIVIDE          (1                         ),
        .CLK_PERIOD      (6.4                       ),
        .OUT0_DIVIDE     (2.0                       ),
        .OUT1_DIVIDE     (1                         ),
        .OUT2_DIVIDE     (1                         ),
        .OUT3_DIVIDE     (1                         )
    ) txoutclk_mmcm0_i (
        .CLK0_OUT        (gt0_txusrclk_i            ),
        .CLK1_OUT        (                          ),
        .CLK2_OUT        (                          ),
        .CLK3_OUT        (                          ),
        .CLK_IN          (gt0_txoutclk_i            ),
        .MMCM_LOCKED_OUT (txoutclk_mmcm0_locked_i   ),
        .MMCM_RESET_IN   (txoutclk_mmcm0_reset_i    )
    );

    assign txoutclk_mmcm0_reset_i   = GT0_TX_MMCM_RESET_IN      ;
    assign gt0_txoutclk_i           = GT0_TXOUTCLK_IN           ;
    assign GT0_TXUSRCLK_OUT         = gt0_txusrclk_i            ;
    assign GT0_TXUSRCLK2_OUT        = gt0_txusrclk_i            ;
    assign GT0_TXCLK_LOCK_OUT       = txoutclk_mmcm0_locked_i   ;
    assign Q0_CLK0_GTREFCLK_OUT     = q0_clk0_gtrefclk          ;


endmodule
