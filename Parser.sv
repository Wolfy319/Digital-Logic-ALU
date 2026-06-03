module parser(
	input logic [7:0] binary_in,
	ouput logic [3:0] hundreds,
	output logic [3:0] tens,
	output logic [3:0] ones
);

	always_comb begin
		hundreds = binary_in / 100;
		tens = (binary_in/10) % 10;
		ones = binary_in % 10;	
	end
	
endmodule