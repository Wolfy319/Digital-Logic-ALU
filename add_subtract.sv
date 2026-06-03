module add_subtract (
  input logic subtract,
  input logic [7:0] a, b,
  output logic overflow,
  output logic [7:0] result
);

logic [7:0] new_b;
logic [7:0] temp_result;
logic cout;

assign new_b = b ^ {8{subtract}};
NBitAdder #(8) adder(
	.A(a),
	.B(new_b),
	.Cin(subtract),
	.Z(temp_result),
	.Cout(cout)
);

assign overflow = (a[7] ~^ (b[7] ^ subtract)) & (a[7] ^ temp_result[7]);


 always_comb begin
    if (subtract) 
        result = a - b;
    else
        result = a + b;
  end

  
endmodule
