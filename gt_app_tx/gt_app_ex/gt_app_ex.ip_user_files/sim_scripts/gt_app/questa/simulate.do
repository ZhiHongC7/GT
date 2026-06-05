onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib gt_app_opt

do {wave.do}

view wave
view structure
view signals

do {gt_app.udo}

run -all

quit -force
