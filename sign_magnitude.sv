/*
Project: 8 Bit ALU
Author:Zhair Malonado Gonzalez
Description: This looks at the 8 bits coming in, and 
looks at the last bit to determine its sign, if its
negative it converts it to its twos complement
positive version as the data bits and then its sign seperately
this is so the program can properly read the numbers.

Sources Used: Textbook on how to do twos complement

*/

module sign_magnitude(
//inputs
	input logic [7:0] alu_bits,
	input logic overflow_in,
//outputs
	output logic sign,
	output logic [7:0] data
);

//check the sign and return it
	assign sign = alu_bits[7];
	always_comb begin
	//convert it to its positve version if its negative
		if (alu_bits[7] == 1'b1) begin
			data = (~alu_bits + 8'b1);
		end else begin
		//otherwise just pass it along
			data = alu_bits;
		end
	end
endmodule