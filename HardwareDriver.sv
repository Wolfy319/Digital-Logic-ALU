module HardwareDriver(
	input logic [7:0] switch_bits,
	input logic [1:0] choice_bits,
	input logic clock, reset_n,
	output logic [6:0] hex0,
	output logic [6:0] hex1,
	output logic [6:0] hex2,
	output logic [6:0] hex3,
	output logic alu_led_overflow,
	output logic [7:0] alu_leds_raw
);
	
	

	
my_alu alu_module(

);

sign_magnitude magnitude(
	.alu_bits(final_result),
	.overflow_in(final_overflow),
	.sign(sign_bit),
	.data(data),
	.overflow_out(alu_led_overflow)
);

parser parse(
	.binary_in(data),
	.hundreds(hundreds),
	.tens(tens),
	.ones(ones)
);

display display_out(
	.sign(sign_bit),
	.hundreds(hundreds),
	.tens(tens),
	.ones(ones),
	.hex0(hex0),
	.hex1(hex1),
	.hex2(hex2),
	.hex3(hex3)
);

	
endmodule