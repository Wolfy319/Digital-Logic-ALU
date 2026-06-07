vsim -gui work.ALUTestbench

add wave clk
add wave enable
add wave reset_n
add wave A
add wave B
add wave opcode
add wave result
add wave prevResultExpected
add wave overflow
add wave prevOverflowExpected

radix signal A decimal
radix signal B decimal
radix signal result decimal
radix signal prevResultExpected decimal

run -all
