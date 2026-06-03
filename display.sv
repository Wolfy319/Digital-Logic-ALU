module display(
	input logic sign,
	input logic[3:0] hundreds,
	input logic[3:0] tens,
	input logic[3:0] ones,
	output logic [6:0] hex0,
	output logic [6:0] hex1,
	output logic [6:0] hex2,
	output logic [6:0] hex3
);

SevenSegmentDecode dec_ones(
	.digits(ones),
	.segments(hex0)
);

SevenSegmentDecode dec_tens(
	.digits(tens),
	.segments(hex1)
);
SevenSegmentDecode dec_hundreds(
	.digits(hundreds),
	.segments(hex2)
);

	always_comb begin
		if (sign == 1'b1) begin
			hex3 = 7'b0111111;
		end else begin
			hex3 = 7'b1111111;
		end
	end
	
endmodule