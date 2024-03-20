`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 02:20:16 PM
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux(a_in, b_in, select, out);
input [31:0] a_in;
input [31:0] b_in;
input select;
output reg [31:0] out;

always@(a_in, b_in, select)

	case(select)
	    2'b0: out = a_in;
	    2'b1: out = b_in;
	default:
	   out = a_in;
	endcase
	
endmodule

/*module mux(
    input [31:0] in0, in1,
    input sel,
    output [31:0] out);

    assign out = sel ? in1 : in0;
endmodule*/