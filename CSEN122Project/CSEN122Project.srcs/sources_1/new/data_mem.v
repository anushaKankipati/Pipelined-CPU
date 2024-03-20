`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 01:47:13 PM
// Design Name: 
// Module Name: data_mem
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
module data_mem(clock, write, read, address, datain, dataout);

    reg[31:0]data[65535:0];
	input [15:0] address;
	input [31:0] datain;
	input clock, read, write;
	output reg [31:0] dataout;
	
	initial begin
	    data[0] = 1;
	    data[1] = 500;
		data[2] = 31;
		data[3] = 1024;
		data[4] = 9;
		data[5] = -2048;
		//data[6] = 10;
		//data[9]= 420;
	end
	
	always@(posedge clock)
		begin
			if(read==1)
				dataout = data[address];
			else if (write ==1)
				data[address] = datain;
		end
/*input clock, write, read;
input [31:0] address;
input [31:0] datain;
reg [31:0] data[65535:0];
output reg [31:0] dataout;

initial
    begin
    data[2]=12;
    
    end 
always@(posedge clock)
begin
    if(read==1)
        dataout=data[address];
    if(write==1)
        data[address]=datain;
end 
endmodule

module instruction(clock, address, instruction_out);
input clock;
input [7:0] address;
wire [31:0] instructions [255:0];

output reg [31:0] instruction_out;

assign instructions[128]=256;
assign instructions[129]=32'b01010101010101010101010101010101;
always@(posedge clock)
    begin
    instruction_out=instructions[address];
    end 
endmodule

module register(clock, write, rs, rt, rd, datain, rs_out, rt_out);
input clock, write;
input [5:0] rs;
input [5:0] rt;
input [5:0] rd;
input [31:0] datain;
reg[31:0] registers[663:0];
output reg[31:0] rs_out;
output reg[31:0] rt_out;

always@(posedge clock)
begin
    if (write==0)
    begin
        rs_out=registers[rs];
        rt_out=registers[rt];
       end
       if(write==1)
        registers[rd]=datain;
end     */

endmodule
