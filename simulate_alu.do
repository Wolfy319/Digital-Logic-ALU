vsim -gui work.ALUTestbench

add wave clk
add wave enable
add wave reset_n
add wave use_A
add wave A
add wave B
add wave opcode
add wave MAX_ERRORS
add wave MAX_ERRORS
add wave result
add wave prevResultExpected
add wave overflow
add wave prevOverflowExpected

radix signal A decimal
radix signal B decimal
radix signal result decimal
radix signal prevResultExpected decimal

run -all
