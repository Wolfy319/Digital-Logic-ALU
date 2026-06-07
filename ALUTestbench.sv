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

	// Number of comparision errors since start of simulation
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

	/* Reset the system, then validate two consecutive days. */
	initial begin
		 numErrors = 0;
		 
		 $readmemb("test_cases.tv", testCases);
		 testNum = 0; numErrors = 0; schedule_end = 0; has_waited_once = 0;
		 
		 #20;
	end

	always @(posedge clk) begin
//		#1;
		{enable,reset_n,use_A,A,B,opcode,overflowExpected,resultExpected} <= testCases[testNum];
		prevResultExpected <= resultExpected;
		prevOverflowExpected <= overflowExpected;
		if (~has_waited_once && A !== 8'bx) begin
			has_waited_once = 1'b1;
		end else if ( (result !== prevResultExpected) || (overflow !== prevOverflowExpected) ) begin
			$display("Error at %0t! Inputs: A=%b=%d, B=%b=%d, opcode=%b, reset_n=%b, enable=%b, use_A=%b", $time, A, A, B, B, opcode, reset_n, enable, use_A);
			$display(" Output: result=%b=%d (%b=%d expected), overflow=%b (%b expected)", result, result, prevResultExpected, prevResultExpected, overflow, prevOverflowExpected);
			numErrors = numErrors + 1;
		end
		testNum = testNum + 1;
		
		if ( (testCases[testNum] === 31'bx) || (numErrors >= MAX_ERRORS) ) begin
			schedule_end = schedule_end + 1;
		end
		if (schedule_end === 3) begin
//			#10;
			$stop;
		end
	end

endmodule
/*
module SevenSegmentTestbench();
    
    logic clk, reset;
    
    logic [3:0] digitTest;
    logic [6:0] segmentsMeasured, segmentsTest;
    
    logic [31:0] vectornum, errors;
    logic [10:0] testvectors[10000:0];

    SevenSegmentDecode dut(
    .digit(digitTest),
    .segments(segmentsMeasured)
    );

    always begin
        clk = 1; #5; clk = 0;
    end
     
    initial begin     
        $readmemb("text.tv", testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end
    
    always @(posedge clk) begin
        #1;
        {digitTest, segmentsTest} = testvectors[vectornum];
    end
	
    always @(negedge clk) begin
        if (~reset) begin
            if (segmentsMeasured !== segmentsTest) begin
                $display("Error: input = %h", digitTest);
                $display(" output = %b (%b expected)", segmentsMeasured, segmentsTest);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 11'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $stop;
            end
        end
    end

endmodule
*/
