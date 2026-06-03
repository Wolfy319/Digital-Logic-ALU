module HardwareDriver(
	input logic [7:0] switch_bits,
	input logic [1:0] choice_bits,
	input logic clock, reset_n,
	output logic [6:0] hex0,
	output logic [6:0] hex1,
	output logic [6:0] hex2,
	output logic [6:0] hex3,
	output logic alu_led_overflow,
	output logic [7:0] alu_leds_raw
);

logic [7:0] a, b;
logic [2:0] opcode;
logic sign_bit;
logic [7:0] data;
logic [3:0] hundreds;
logic [3:0] tens;
logic [3:0] ones;

always_ff @(posedge clock) begin
	case (choice_bits)
		2'b00: begin
			opcode <= switch_bits[2:0];
		end
		
		2'b01: begin
			a <= switch_bits;
		end
		
		2'b10: begin
			b <= switch_bits;
		end
	endcase
end

my_alu alu_module(
	.enable(clock),
	.reset_n(reset_n),
	.clock(clock),
	.A(a),
	.B(b),
	.opcode(opcode),
	.result(alu_leds_raw),
	.overflow(alu_led_overflow)
);

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

display display_out(
	.sign(sign_bit),
	.hundreds(hundreds),
	.tens(tens),
	.ones(ones),
	.hex0(hex0),
	.hex1(hex1),
	.hex2(hex2),
	.hex3(hex3)
);

	
endmodule