/*
 * ECE 204 8Bit ALU
* full adder module
*
* Author: David Smith
*
* Description: A 1 bit full adder I created in order to be able to control the 
* carry in bits
*/

module full_adder (
	input logic A, B, Cin,
	output logic Z, Cout
);

// Set Z to be the xor of A, B, and Cin
assign Z = A ^ B ^ Cin;
// Set the carry out to be true if A and B or there's a carry in and exactly
// one of A and B are true
assign Cout = (A & B) | (Cin & (A ^ B));

endmodule
