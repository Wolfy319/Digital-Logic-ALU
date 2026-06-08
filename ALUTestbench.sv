/*
Authors: David
Description: The testbench for the ALU. Loads a set of test vectors from a provided
file and runs all the tests, checking for errors.
Sources Used: Class Textbook and Class slides
*/
module ALUTestbench();
	localparam MAX_ERRORS = 10;

	// Module inputs
	logic clk, reset_n, enable, use_A;
	logic [7:0] A, B;
	logic [2:0] opcode;

	// Module outputs
	logic [7:0] result;
	logic overflow;

	// Expected outputs
	logic [7:0] resultExpected, prevResultExpected;
	logic overflowExpected, prevOverflowExpected;

	// The test vectors and logic variables
	logic [30:0] testCases[9999:0];
	logic has_waited_once;
	int numErrors, testNum, schedule_end;

	/*
	 * Instantiate ALU device under test.
	 */
	my_alu dut (
		 .enable(enable),
		 .reset_n(reset_n),
		 .clock(clk),
		 .use_A(use_A),
		 .A(A),
		 .B(B),
		 .opcode(opcode),
		 
		 .result(result),
		 .overflow(overflow)
	);

	// Start clock generator
	always begin
		 clk = 1'b0;
		 #5;
		 clk = 1'b1;
		 #5;
	end

	/* Read the file of test_vectors and initialize variables to 0 */
	initial begin
		 numErrors = 0;
		 
		 $readmemb("test_cases.tv", testCases);
		 testNum = 0; numErrors = 0; schedule_end = 0; has_waited_once = 0;
		 
		 #20;
	end

	always @(posedge clk) begin
                // Set the inputs and expected outputs to the test_vector
		{enable,reset_n,use_A,A,B,opcode,overflowExpected,resultExpected} <= testCases[testNum];

                // Store the previous expected results into variables
		prevResultExpected <= resultExpected;
		prevOverflowExpected <= overflowExpected;

		if (~has_waited_once && A !== 8'bx) begin 
                        // Don't perform comparison on the first clock cycle
			has_waited_once = 1'b1;
		end else if ( (result !== prevResultExpected) || (overflow !== prevOverflowExpected) ) begin
                        // Otherwise, if the results don't match the expected
                        // results, display an error
			$display("Error at %0t! Inputs: A=%b=%d, B=%b=%d, opcode=%b, reset_n=%b, enable=%b, use_A=%b", $time, A, A, B, B, opcode, reset_n, enable, use_A);
			$display(" Output: result=%b=%d (%b=%d expected), overflow=%b (%b expected)", result, result, prevResultExpected, prevResultExpected, overflow, prevOverflowExpected);
			numErrors = numErrors + 1;
		end

                // Increment the test number
		testNum = testNum + 1;
		
                // If there have been too many errors or we run out of test
                // cases, then schedule the testbench to end
		if ( (testCases[testNum] === 31'bx) || (numErrors >= MAX_ERRORS) ) begin
			schedule_end = schedule_end + 1;
		end

                // 3 clock cycles after the testbench has been scheduled to
                // end, end the testbench
		if (schedule_end === 3) begin
			$stop;
		end
	end

endmodule
