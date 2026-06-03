module full_adder (
	input logic A, B, Cin,
	output logic Z, Cout
);

assign Z = A ^ B ^ Cin;
assign Cout = (A & B) | (Cin & (A ^ B));

endmodule