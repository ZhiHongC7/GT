vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_tx_startup_fsm.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_rx_startup_fsm.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_init.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_gt.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_multi_gt.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_sync_block.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app.v" \


vlog -work xil_defaultlib \
"glbl.v"

