/*
Author: Zhair Maldonado Gonzalez

Description: This is really a wrapper to neatly connect
all of my individual sections for the hexes together,
it gets the numbers for the ones, tens and hundereds places
as an input, then it figures out what to segements to turn off
and on and outputs them.
*/

module display(
// inputs
	input logic sign,
	input logic[3:0] hundreds,
	input logic[3:0] tens,
	input logic[3:0] ones,
//outputs
	output logic [6:0] hex0,
	output logic [6:0] hex1,
	output logic [6:0] hex2,
	output logic [6:0] hex3
);

//figure out what number to display in the ones
SevenSegmentDecode dec_ones(
	.digit(ones),
	.segments(hex0)
);
//figure out what number to display in the tens
SevenSegmentDecode dec_tens(
	.digit(tens),
	.segments(hex1)
);
//figure out what number to display in the hundreds
SevenSegmentDecode dec_hundreds(
	.digit(hundreds),
	.segments(hex2)
);
//check the sign bit, if its negative, display the '-' on the fpga
	always_comb begin
		if (sign == 1'b1) begin
			hex3 = 7'b0111111;
			//otherwise leave the sign off
		end else begin
			hex3 = 7'b1111111;
		end
	end
	
endmodule