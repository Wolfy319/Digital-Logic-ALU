module Parser (
	input logic [7:0] binary_in,
	output logic [3:0] hundreds, tens, ones
);

	always_comb begin
		hundreds = binary_in / 100;
		tens = (binary_in/10) % 10;
		ones = binary_in % 10;	
	end
	
endmodule