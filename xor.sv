/*
Author: David Smith
Description: gets an input from A and B,
compares the bits and if only one of the bit pairs
is 1 then return 1, otherwise return 0

Sources Used:Textbook,
*/

module my_xor8 (
  input logic [7:0] a, b,
  output logic [7:0] result
);
//compares the two 
assign result = a ^ b;

endmodule
