`timescale 1ns / 1ps

module gt_app_TB;

//*************************Parameter Declarations******************************

    parameter   TX_REFCLK_PERIOD   =   6.4;
    parameter   RX_REFCLK_PERIOD   =   6.4;
    parameter   SYSCLK_PERIOD      =   10.0;
    parameter   DCLK_PERIOD        =   10.0;
  
//************************Internal Register Declarations***********************

//************************** Register Declarations ****************************        

reg             tx_refclk_n_r;
reg             rx_refclk_n_r;
reg             drp_clk_r;
reg             sysclk_r;
reg             tx_usrclk_r;
reg             rx_usrclk_r;    
reg             gsr_r;
reg             gts_r;
reg             reset_i;
reg             track_data_high_r;
reg             track_data_low_r;
//********************************Wire Declarations**********************************

    //--------------------------------- Global Signals ------------------------------
wire            tx_refclk_p_r;
wire            rx_refclk_p_r; 
    
    //-------------------------- Example Module Connections -------------------------
wire            track_data_i;
wire            rxn_in_i;
wire            rxp_in_i;
wire            txn_out_i;
wire            txp_out_i;

//*********************************Main Body of Code**********************************


    // ------------------------------- Tie offs -------------------------------- 
    
    wire  tied_to_ground_i;
    assign  tied_to_ground_i     =    1'b0;
    
    // ------------------------- GT Serial Connections ------------------------
    assign   rxn_in_i           =  txn_out_i;
    assign   rxp_in_i           =  txp_out_i;  
    //------------------------------ Global Signals ----------------------------
    
    //Simulate the global reset that occurs after configuration at the beginning
    //of the simulation. 
    assign glbl.GSR = gsr_r;
    assign glbl.GTS = gts_r;

    initial
        begin
            gts_r = 1'b0;        
            gsr_r = 1'b1;
            #(16*TX_REFCLK_PERIOD);
            gsr_r = 1'b0;
    end


    //---------- Generate Reference Clock input to UPPER GTCLK ----------------
    
    initial begin
        tx_refclk_n_r = 1'b1;
    end

    always  
        #(TX_REFCLK_PERIOD/2) tx_refclk_n_r = !tx_refclk_n_r;

    assign tx_refclk_p_r = !tx_refclk_n_r;

    initial begin
        rx_refclk_n_r = 1'b1;
    end

    always  
        #(RX_REFCLK_PERIOD/2) rx_refclk_n_r = !rx_refclk_n_r;

    assign rx_refclk_p_r = !rx_refclk_n_r;
                 
    //------------------------ Generate DRP Clock ----------------------------
    
    initial begin
        drp_clk_r = 1'b1;
    end

    always  
        #(DCLK_PERIOD/2) drp_clk_r = !drp_clk_r;
      
    //------------------------ Generate System Clock ----------------------------
    initial begin
        sysclk_r = 1'b1;
    end

    always  
        #(SYSCLK_PERIOD/2) sysclk_r = !sysclk_r;
    
    //--------------------------------- Resets ---------------------------------
    
    initial
    begin
        $display("Timing checks are not valid");
        reset_i = 1'b1;
        #200 reset_i = 1'b0;
        $display("Timing checks are valid");
    end
    
    //----------------------------- Track Data ---------------------------------
    initial
    begin
        #549000;
        $display("------- TEST COMPLETED -------");
            $display("------- Test Completed Successfully-------");
        $stop;
    end
 

    //----------------- Instantiate an gt_app_exdes module  -----------------

    gt_app_exdes gt_app_exdes_i(
        .DRPCLK_IN                           (drp_clk_r     ),
        .Q0_CLK0_GTREFCLK_PAD_N_IN           (tx_refclk_n_r ), 
        .Q0_CLK0_GTREFCLK_PAD_P_IN           (tx_refclk_p_r ),
        .TXN_OUT                             (txn_out_i     ),
        .TXP_OUT                             (txp_out_i     )
    );


    rx_gt_app_exdes rx_gt_app_exdes_i(
        .Q0_CLK0_GTREFCLK_PAD_N_IN           (tx_refclk_n_r ), 
        .Q0_CLK0_GTREFCLK_PAD_P_IN           (tx_refclk_p_r ),
        .DRP_CLK_IN_P                        (drp_clk_r     ),
        .DRP_CLK_IN_N                        (~ drp_clk_r   ),
        .TRACK_DATA_OUT                      (track_data_i  ),
        .RXN_IN                              (rxn_in_i      ),
        .RXP_IN                              (rxp_in_i      )
    );

endmodule
