//`define TICKS_PER_SECOND   5

`define MAX_ERRORS 10

module ALUTestbench();

/* Declare internal logic */

// Module inputs
logic clk;
logic reset_n;

// Module outputs
//logic [25:0] tickMeasured;


// Expected outputs
//logic [25:0] tickExpected;

// Number of comparision errors since start of simulation
int numErrors;

always begin
    clk = 1'b0;
    #2;
    clk = 1'b1;
    #2;
end

/*
 * Instantiate Clock device under test.
 *
 * TODO Change signal names as needed to match your Clock module.  Use Ctrl+H
 *      to search and replace in Quartus.
 */
my_alu dut (
    .clock(clk),
    .reset_n(reset_n),
    .tick_count(tickMeasured),
    .second_count(secondMeasured),
    .minute_count(minuteMeasured),
    .hour_count(hourMeasured)
);

/* Perform a reset of the clock module */
task reset();
    reset_n = 1'b0;
    #10;
    reset_n = 1'b1;
endtask

/*
 * Validate that all mesured outputs match the expected values.  Print an
 * error message if the outputs are incorrect.  Stop simulation if too many
 * errors occur.
 */
task validateState();
    if (tickExpected !== tickMeasured || secondExpected !== secondMeasured ||
            minuteExpected !== minuteMeasured || hourExpected !== hourMeasured)
    begin

        numErrors++;
        if (`MAX_ERRORS < numErrors) begin
            $display("Too many errors.  Halting simulation.");
            $stop;
        end

        // Print current time, measured & expected quantities
        // Format hour:minute:second.tick
        $display("%0tps: measured %2d:%2d:%2d.%1d expected %2d:%2d:%2d.%1d",
            $time,
            hourMeasured, minuteMeasured, secondMeasured, tickMeasured,
            hourExpected, minuteExpected, secondExpected, tickExpected,
        );

    end
//	$display("%0tps: measured %2d:%2d:%2d.%1d expected %2d:%2d:%2d.%1d",
//		$time,
//		hourMeasured, minuteMeasured, secondMeasured, tickMeasured,
//		hourExpected, minuteExpected, secondExpected, tickExpected,
//	);
endtask

/*
 * Validate 24 consecutive hours.
 */
task validateDay();	
		for (int i = 0; i < `HOURS_PER_DAY; i++) begin
		minuteExpected <= 0;
			for(int j = 0; j < `MINUTES_PER_HOUR; j++) begin
			secondExpected <= 0;
				for(int k = 0; k < `SECONDS_PER_MINUTE; k++) begin
				tickExpected <= 0;
					for(int l = 0; l < `TICKS_PER_SECOND; l++) begin
						#4;
						validateState();
						tickExpected++;
					end
					secondExpected++;
				end
				minuteExpected++;
			end
			hourExpected++;
		end
		hourExpected = 0;
endtask

/* Reset the system, then validate two consecutive days. */
initial begin
    reset_n = 1'b1;
    numErrors = '0;
    hourExpected = '0;
    minuteExpected = '0;
    secondExpected = '0;
    tickExpected = '0;
	 
    reset();
    validateDay();
    validateDay();
    if (0 == numErrors) begin
        $display("Clock module validated successfully!");
    end
    $stop;
end

endmodule

