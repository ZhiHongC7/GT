`timescale 1ns / 1ps
`define DLY #1


//***********************************Entity Declaration*******************************

module gt_app_GT_USRCLK_SOURCE (
    input           GT0_TXOUTCLK_IN             ,
    input           GT0_TX_MMCM_RESET_IN        ,
    output          GT0_TXUSRCLK_OUT            ,
    output          GT0_TXUSRCLK2_OUT           ,
    output          GT0_TXCLK_LOCK_OUT
);

    wire            w_gt0_txusrclk          ;

//*********************************** Beginning of Code *******************************

    gt_app_CLOCK_MODULE # (
        .MULT            (4.0                       ),
        .DIVIDE          (1                         ),
        .CLK_PERIOD      (6.4                       ),
        .OUT0_DIVIDE     (2.0                       ),
        .OUT1_DIVIDE     (1                         ),
        .OUT2_DIVIDE     (1                         ),
        .OUT3_DIVIDE     (1                         )
    ) txoutclk_mmcm0_i (
        .CLK0_OUT        (w_gt0_txusrclk            ),
        .CLK1_OUT        (                          ),
        .CLK2_OUT        (                          ),
        .CLK3_OUT        (                          ),
        .CLK_IN          (GT0_TXOUTCLK_IN           ),
        .MMCM_LOCKED_OUT (GT0_TXCLK_LOCK_OUT        ),
        .MMCM_RESET_IN   (GT0_TX_MMCM_RESET_IN      )
    );

    assign GT0_TXUSRCLK_OUT  = w_gt0_txusrclk;
    assign GT0_TXUSRCLK2_OUT = w_gt0_txusrclk;


endmodule
