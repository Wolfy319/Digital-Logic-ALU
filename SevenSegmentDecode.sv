/*
 * ECE 204 8Bit ALU
 * Seven Segment Decoder Skeleton File
 *
 * Adapted from Harris & Harris "Digital Design and Computer Achitecture"
 * Example 4.25 "Seven-Segment Display Decoder" (Page 198)
 *
 * Author(s): Zhair Maldonado

 Description: Takes a binary number and converts it to our seven segment display to properly display
 the result on the hex display
 Sources Used: Lab 3B example, Textbook
 */
module SevenSegmentDecode(
    input logic [3:0] digit,
	 output logic [6:0] segments
);

 */
always_comb begin
    case (digit)
        //                   gfe_dcba
        4'h0: segments = 7'b100_0000;
        // turns on and off certain segements of the work
		  4'h1: segments = 7'b1111001;
		  4'h2: segments = 7'b0100100;
		  4'h3: segments = 7'b0110000;
		  4'h4: segments = 7'b0011001;
		  4'h5: segments = 7'b0010010;
		  4'h6: segments = 7'b0000010;
		  4'h7: segments = 7'b1111000;
		  4'h8: segments = 7'b0000000;
		  4'h9: segments = 7'b0011000;
		  4'ha: segments = 7'b0001000;
		  4'hb: segments = 7'b0000011;
		  4'hc: segments = 7'b1000110;
		  4'hd: segments = 7'b0100001;
		  4'he: segments = 7'b0000110;
		  4'hf: segments = 7'b0001110;
		  
		  default: segments = 7'bxxxxxxx;
		  
    endcase
end

endmodule

