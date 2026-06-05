vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_tx_startup_fsm.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_rx_startup_fsm.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app_init.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app_gt.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app_multi_gt.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_sync_block.v" \
"../../../../gt_app.srcs/sources_1/ip/gt_app/gt_app.v" \


vlog -work xil_defaultlib \
"glbl.v"

