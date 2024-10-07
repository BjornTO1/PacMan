onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /create_board_testbench/clk
add wave -noupdate /create_board_testbench/gameover
add wave -noupdate -radix unsigned /create_board_testbench/x
add wave -noupdate -radix unsigned /create_board_testbench/y
add wave -noupdate /create_board_testbench/back_on
add wave -noupdate /create_board_testbench/dut/board_x
add wave -noupdate /create_board_testbench/dut/board_y
add wave -noupdate /create_board_testbench/dut/row_pixels
add wave -noupdate /create_board_testbench/dut/color
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {231 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {116 ps}
