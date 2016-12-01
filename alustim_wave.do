onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /alustim/A
add wave -noupdate -radix hexadecimal /alustim/B
add wave -noupdate /alustim/cntrl
add wave -noupdate -radix hexadecimal /alustim/result
add wave -noupdate /alustim/carry_out
add wave -noupdate /alustim/negative
add wave -noupdate /alustim/overflow
add wave -noupdate /alustim/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10443174170 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {10080806142 ps} {10890448514 ps}
