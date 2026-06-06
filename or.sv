/*
Author: David Smith
Description: Takes in two inputs, A and B
compare them and if the pair of bits has at least 1
1, return 1, otherwise return 0

sources used: textbook, class examples

*/
module my_or8 (
  input logic [7:0] a, b,
  output logic [7:0] result
);

assign result = a | b;

endmodule
