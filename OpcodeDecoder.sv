module OpcodeDecoder (
	input logic enable, reset_n, add_sub_overflow,
	input logic [2:0] opcode,
	input logic [7:0] and_result, or_result, xor_result, add_result, sub_result, a_input, b_input,
	output logic [7:0] result,
	output logic result_overflow
);

always_comb begin
	// If enabled, decode opcode
	if(reset_n === 1'b0 or ~enable) begin
		result <= 7'b0;
		result_overflow <= 1'b0;
	end if (enable) begin
		// Pick correct result based on opcode
		case (opcode)
			000: result <= and_result;
			001: result <= or_result;
			010: result <= xor_result;
			011: result <= a_input;
			100: result <= add_sub_result;
			101: result <= add_sub_result;
		// 110: result <= unused;	
			111: result <= b_input;
			default: result <= 7'b0;
		endcase
		
		// Update overflow bit
		result_overflow <= add_sub_overflow;
	end else 
	
end

endmodule

