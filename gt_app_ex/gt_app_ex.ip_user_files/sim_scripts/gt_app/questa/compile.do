vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_tx_startup_fsm.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_rx_startup_fsm.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_init.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_gt.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app_multi_gt.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app/example_design/gt_app_sync_block.v" \
"../../../../gt_app_ex.srcs/sources_1/ip/gt_app/gt_app.v" \


vlog -work xil_defaultlib \
"glbl.v"

