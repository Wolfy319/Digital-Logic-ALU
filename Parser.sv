/*
Author: Zhair Maldonado Gonzalez
Description: getting the raw binary, converts it to decimals
specifically seperates it into its hundreds, tens and ones
places. Does this by dividing the decimal values with modulo
to get the remainders for the place its looking for.*/


module Parser (
//input
	input logic [7:0] binary_in,
	//output
	output logic [3:0] hundreds, tens, ones
);

	always_comb begin
	//figure out the number in the hundreds
		hundreds = binary_in / 100;
		//figure out the number in the tens
		tens = (binary_in/10) % 10;
		//figure out the number in the ones
		ones = binary_in % 10;	
	end
	
endmodule