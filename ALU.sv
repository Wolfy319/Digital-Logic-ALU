module my_alu (
	input logic enable, reset_n, clock,
	input logic [7:0] A, B,
	input logic [2:0] opcode,

   output logic [7:0] result,
   output logic overflow
);

	
	logic sign_bit;
	logic subtract_bit;
	logic [7:0] data;
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
		.result(op_add_sub_result),	
		.overflow(add_sub_overflow)
	);

	OpcodeDecoder Decoder(
		.opcode(opcode),
		.and_result(op_and_result),
		.or_result(op_or_result),
		.xor_result(op_xor_result),
		.add_result(op_add_sub_result),
		.sub_result(op_add_sub_result),
		.add_sub_overflow(add_sub_overflow),
		.result(final_result),
		.result_overflow(final_overflow)
	);

   always_ff @(posedge clock) begin
       //result <= final_result;
       overflow <= final_overflow;
   end

endmodule
