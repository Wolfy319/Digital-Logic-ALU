/*
Author: David Smith
Description: gets two 8-bit numbers and a bit deciding whether to add or subtract
If adding, add A and B. If subtracting, add A to the 1's Complement of B and then
add 1
sources: Textbook and class lecture
*/
module add_subtract (
  input logic subtract,
  input logic [7:0] a, b,
  output logic overflow,
  output logic [7:0] result
);

// Declare a temporary result and a modified b wire
logic [7:0] new_b;
logic [7:0] temp_result;
logic cout;

// Assign the modified b to be B bitwise xored with the subtraction bit.
assign new_b = b ^ {8{subtract}};

// Add A and the modified B, with the subtract bit as the carry
NBitAdder #(8) adder(
	.A(a),
	.B(new_b),
	.Cin(subtract),
	.Z(result),
	.Cout(cout)
);

// Assign the overflow bit to true if A and the second operand have the same 
// sign, and the result doesn't match that sign.
assign overflow = (a[7] ~^ (b[7] ^ subtract)) & (a[7] ^ result[7]);
  
endmodule
