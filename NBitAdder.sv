/*
Author: David Smith
Description: A N-Bit adder creates using many instances of the 1-bit full adder
I created. Necessary so that I can perform addition w/ control over the carry bit, 
which isn't provided by the built in + operator.
*/

module NBitAdder 
#(parameter N = 8) 
(
	input logic Cin,
	input logic [N-1:0] A, B,
	output logic Cout,
	output logic [N-1:0] Z
);
	
   // Create arrays of carry-ins and carry-outs
   logic [N-1:0] Cins, Couts;
   // Set the first carry-in to the carry-in input
   assign Cins[0] = Cin;

   // Generates N 1-bit full adders and hooks them up into an N-bit ripple
   // carry adder
	genvar i;
   generate
        for (i = 0; i < N; i++) begin: bit_loop
            full_adder bit_adder(
                .A(A[i]),
                .B(B[i]),
                .Cin(Cins[i]),
                .Z(Z[i]),
                .Cout(Couts[i])
            );
        end 
		  for (i = 1; i < N; i++) begin: carry_loop
				assign Cins[i] = Couts[i-1];
		  end
   endgenerate

   // Assign the Cout output to the last carry bit in the array
   assign Cout = Couts[N-1];
	
endmodule
