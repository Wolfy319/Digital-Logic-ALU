/*
 * ECE 204 8Bit ALU
 * Main ALU module
 *
* Authors: David Smith, Zhair Maldonado Gonzalez, Wolfy Fiorini
*
* Description: The main arithmatic unit for the entire project
* It holds the modules for all the operations, and runs them once the opcode
* switch is enabled, does this a singular time to allow previous results to be added. 
* The opcode then selects which of these operations results the ALU will output.
* Has a register for the results to be stored
* Will also allow for its value to be erased with a reset button.
*
* Sources Used: Class Textbook and Class slides
*/

module my_alu (
	input logic enable, reset_n, clock, use_A,
	input logic [7:0] A, B,
	input logic [2:0] opcode,
   output logic [7:0] result,
   output logic overflow
);

	// Intermediary signals for passing values between modules
	logic sign_bit;
	logic subtract_bit;
	logic [7:0] data, input1;
	logic [7:0] op_and_result, op_or_result, op_xor_result, op_add_sub_result;
	logic [7:0] final_result;
	logic add_sub_overflow, final_overflow;
	
	assign subtract_bit = opcode[0];
   assign input1 = use_A ? A : result;
	
	// Initialize operation modules and hookup signals
	my_and8 AndModule(
		.a(input1),
		.b(B),
		.result(op_and_result)
	);
	
	my_or8 OrModule(
		.a(input1),
		.b(B),
		.result(op_or_result)		
	);
	
	my_xor8 XorModule(
		.a(input1),
		.b(B),
		.result(op_xor_result)	
	);
	
	add_subtract AddSubModule(
		.subtract(subtract_bit),
		.a(input1),
		.b(B),
		.result(op_add_sub_result),	
		.overflow(add_sub_overflow)
	);
	
	// Feed opcode and operation results into the decoder and get the final result
	OpcodeDecoder Decoder(
		.opcode(opcode),
		.enable(enable),
		.reset_n(reset_n),
		.and_result(op_and_result),
		.or_result(op_or_result),
		.xor_result(op_xor_result),
		.add_result(op_add_sub_result),
		.sub_result(op_add_sub_result),
		.add_sub_overflow(add_sub_overflow),
		.a_input(input1),
		.b_input(B),
		.result(final_result),
		.result_overflow(final_overflow)
	);

	// Reset register if reset_n is LOW, otherwise save the final values to the register
   always_ff @(posedge clock) begin
		if(~reset_n) begin
			result <= 8'b0;
			overflow <= 1'b0;
		end else if (enable) begin
			result <= final_result;
			overflow <= final_overflow;
		end
   end

endmodule
