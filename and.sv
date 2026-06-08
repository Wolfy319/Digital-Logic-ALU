/*
Author: David Smith
Description: gets two inputs, and compares the bits
if a and b are both 1, output 1, else output 0
sources: Textbook and class lecture
*/

module my_and8 (
  input logic [7:0] a, b,
  output logic [7:0] result
);

//compare the two results
assign result = a & b;

endmodule
