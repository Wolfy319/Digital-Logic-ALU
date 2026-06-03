module sign_magnitude(
	input logic [7:0] alu_bits,
	input logic overflow,
	output logic sign,
	output logic [7:0] data,
	output logic overflow_out
);

	assign overflow_out = overflow
	assign sign = alu_bits[7];
	always_comb begin
		if (alu_bits[7] == 1'b1) begin
			data = (~alu_bits + 8'b1);
		end else begin
			data = alu_bits;
		end
	end
endmodule