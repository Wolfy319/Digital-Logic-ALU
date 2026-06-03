module NBitAdder 
#(parameter N = 8) 
(
	input logic Cin,
	input logic [N-1:0] A, B,
	output logic Cout,
	output logic [N-1:0] Z
);
	
	// assign {Z,Cout} = A + B + Cin;
	
   logic [N-1:0] Cins, Couts;
   assign Cins[0] = Cin;

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

   assign Cout = Couts[N-1];
	
endmodule
