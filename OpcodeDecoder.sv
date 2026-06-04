module OpcodeDecoder (
	input logic enable, reset_n, add_sub_overflow,
	input logic [2:0] opcode,
	input logic [7:0] and_result, or_result, xor_result, add_result, sub_result, a_input, b_input,
	output logic [7:0] result,
	output logic result_overflow
);

always_comb begin
	// If enabled, decode opcode
	if(reset_n === 1'b0 || ~enable) begin
		result = 8'b0;
		result_overflow = 1'b0;
	end else begin
		// Pick correct result based on opcode
		case (opcode)
			3'b000: result = and_result;
			3'b001: result = or_result;
			3'b010: result = xor_result;
			3'b011: result = a_input;
			3'b100: result = add_result;
			3'b101: result = sub_result;
		// 3'b110: result = unused;	
			3'b111: result = b_input;
			default: result = 8'b0;
		endcase
		
		// Update overflow bit
		result_overflow = (opcode[2]&~opcode[1]) ? add_sub_overflow : 1'b0;
	end
	
end

endmodule

