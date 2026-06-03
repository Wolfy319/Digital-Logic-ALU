module my_xor8 (
  input logic [7:0] a, b,
  output logic [7:0] result
);

assign result = a ^ b;

endmodule
