/*
Authors: David, Zhair, Wolfy 
*/

module HardwareDriver(
	input logic [7:0] switch_bits,
	input logic [1:0] choice_bits,
	input logic clock, reset_n, choose_mode_n,
	output logic [6:0] Seg0,
	output logic [6:0] Seg1,
	output logic [6:0] Seg2,
	output logic [6:0] Seg3,
	output logic [6:0] Seg5,
	output logic alu_led_overflow,
	output logic [7:0] alu_leds_raw
);

// Intermediate signals to allow passing between modules
logic [7:0] a, b, a_final, b_final;
logic [2:0] opcode;
logic sign_bit;
logic [7:0] data;
logic [3:0] hundreds;
logic [3:0] tens;
logic [3:0] ones;
logic [3:0] mode_display_num;
logic enable;

// Parse the signal from the switches to determine which input to update
// and update it on the next clock cycle
always_comb begin
	case (choice_bits)
		2'b00: mode_display_num <= 4'h0;
		2'b01: mode_display_num <= 4'ha;
		2'b10: mode_display_num <= 4'hb;
		default: mode_display_num <= 4'h0;
	endcase
end

always_ff @(posedge ~choose_mode_n, posedge ~reset_n) begin
	if (~reset_n) begin
		opcode <= 3'b000;
		a_final <= 8'b00000000;
		b_final <= 8'b00000000;
		a <= 8'b00000000;
		b <= 8'b00000000;
	end else begin
		case (choice_bits)
			2'b00: begin
				opcode <= switch_bits[2:0];
				a_final <= a;
				b_final <= b;
				enable <= 1'b1;
			end
			
			2'b01: begin
				a <= switch_bits;
				enable <= 1'b0;
			end
			
			2'b10: begin
				b <= switch_bits;
				enable <= 1'b0;
			end
		endcase
	end
end

// Feed the stored inputs into the ALU and retrieve the calculated result (if enabled)
my_alu alu_module(
	.enable(1'b1),
	.reset_n(reset_n),
	.clock(clock),
	.A(a_final),
	.B(b_final),
	.opcode(opcode),
	.result(alu_leds_raw),
	.overflow(alu_led_overflow)
);

// Parse and format the resut
sign_magnitude magnitude(
	.alu_bits(alu_leds_raw),
	.overflow_in(alu_led_overflow),
	.sign(sign_bit),
	.data(data)
);

Parser parse(
	.binary_in(data),
	.hundreds(hundreds),
	.tens(tens),
	.ones(ones)
);

// Send the parsed values to be displayed on the FPGA
display display_out(
	.sign(sign_bit),
	.hundreds(hundreds),
	.tens(tens),
	.ones(ones),
	.mode_number(mode_display_num),
	.hex0(Seg0),
	.hex1(Seg1),
	.hex2(Seg2),
	.hex3(Seg3),
	.hex5(Seg5)
);
	
endmodule
