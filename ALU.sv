module ALU (
	input logic enable, reset_n,
	input logic [7:0] A, B,
	input logic [2:0] opcode
	output logic [6:0] hex0,
	output logic [6:0] hex1,
	output logic [6:0] hex2,
	output logic [6:0] hex3,
	output logic alu_led_overflow,
	output logic [7:0] alu_leds_raw
);

	
	logic sign_bit
	logic subtract_bit;
	logic [7:0] data;
	logic [3:0] hundreds;
	logic [3:0] tens;
	logic [3:0] ones;
	logic [7:0] op_and_result, op_or_result, op_xor_result, op_add_sub_result;
	logic [7:0] final_result;
	logic add_sub_overflow, final_overflow;
	
	assign subtract_bit = opcode[2];
	
	my_and8 AndModule(
		.a(A),
		.b(B),
		.result(op_and_result)
	);
	
	my_or8 OrModule(
		.a(A),
		.b(B),
		.result(op_or_result)		
	);
	
	my_xor8 XorModule(
		.a(A),
		.b(B),
		.result(op_xor_result)	
	);
	
	add_subtract AddSubModule(
		.subtract(subtract_bit),
		.a(A),
		.b(B),
		.result(op_addsub_result),	
		.overflow(add_sub_overflow)
	);

	OpcodeDecoder Decoder(
		.opcode(opcode),
		.and_result(op_and_result),
		.or_result(op_or_result),
		.xor_result(op_xor_result),
		.add_result(op_add_result),
		.sub_result(op_sub_result),
		.add_sub_overflow(add_sub_overflow),
		.result(final_result),
		.result_overflow(final_overflow)
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