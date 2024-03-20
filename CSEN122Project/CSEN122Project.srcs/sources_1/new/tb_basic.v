`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 02:31:28 PM
// Design Name: 
// Module Name: tb_basic
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2024 04:05:59 PM
// Design Name: 
// Module Name: test_bench
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//dont need alu2_out, alu2_out_out, jumpMem, jumpMem_out
//move jump is in ID stage
module test_bench();
	wire [31:0] A;
	wire [31:0] alu3_out_out;
	wire [31:0] ex_dataMemoryOut_out;
	wire ex_jumpMem_out, or1_out;
	wire [31:0] dataOut;

	mux test(A, alu3_out_out, ex_dataMemoryOut_out, ex_jumpMem_out, or1_out, dataOut); //very 1st mux
	wire [7:0] PCOut;
	reg clock;
	
	initial
	begin
		clock = 0;
		forever #5 clock = ~clock;
	end
	
	program_counter test1(dataOut[7:0], PCOut, clock); //unsure of which bits
	
	wire N, Z;
	
	alu test1_5({24'b000000000000000000000000, PCOut}, 1, 4'b0, A, N, Z); //PC = PC+1

	wire [31:0] im_out; //instruction memory out
		
	instruction_memory test2(PCOut, clock, im_out);
	wire [31:0] if_im_out; //inst fetch inst mem out
	
	if_design test3(im_out, PCOut, clock, if_im_out, if_PCOut);
	
	wire [31:0] signOut;
	sign_extender test4(if_im_out[21:0], signOut);
	
	wire [31:0] alu2_out; //this is unnecessary, wherever it is, remove
	alu test4_5(signOut, {24'b000000000000000000000000, if_PCOut}, 4'b0, alu2_out, N, Z); //PC + y, uneccessary for us

	wire [31:0] rsOut;
	wire [31:0] rtOut;
	wire [5:0] rd_out_out;
	wire [31:0] mux2_out;
	wire ex_regWrite_out;
	register_file test5(if_im_out[21:16], if_im_out[15:10], rd_out_out, mux2_out, clock, ex_regWrite_out, rsOut, rtOut); 
	
	wire [3:0] aluOp;
	wire regWrite, memtoReg, PCtoReg, branchN, branchZ, jump, memRead, memWrite, jumpMem;
	
	control_unit test6(if_im_out[31:28], regWrite, memtoReg, PCtoReg, branchN, branchZ, jump, jumpMem, aluOp, memRead, memWrite);
	
	wire [31:0] rsOut_out;
	wire [31:0] rtOut_out;
	wire [5:0] rd_out;
	wire [31:0] alu2_out_out;
	wire [3:0] aluOp_out;
	wire memRead_out, memWrite_out, branchN_out, branchZ_out, jump_out, PCtoReg_out, memtoReg_out, regWrite_out, jumpMem_out;

	id_design test7(rsOut, rtOut, if_im_out[27:22], alu2_out, memRead, memWrite, aluOp, branchN, branchZ, jump, jumpMem, PCtoReg, memtoReg, regWrite,
									rsOut_out, rtOut_out, alu2_out_out, memRead_out, memWrite_out, aluOp_out, branchN_out, branchZ_out, jump_out, jumpMem_out, PCtoReg_out,
									memtoReg_out, regWrite_out, rd_out, clock);
	
	wire [31:0] dataMemoryOut;
	data_memory test8(rsOut_out, rtOut_out, aluOp_out, alu3_out, alu3_N, alu3_Z);

	wire [31:0] alu3_out;
	wire alu3_Z, alu3_N;
	alu test9(rsOut_out, rtOut_out, aluOp_out, alu3_out, alu3_N, alu3_Z);

	wire [31:0] ex_alu2_out_out;
	wire ex_branchN_out, ex_branchZ_out, ex_jump_out, ex_PCtoReg_out, ex_memtoReg_out, ex_nFlagOut, ex_zFlagOut;
	
	ex_design test10(dataMemoryOut, alu3_out, rd_out, alu2_out_out, alu3_N, alu3_Z, branchN_out, branchZ_out, jump_out, PCtoReg_out, memtoReg_out, regWrite_out, ex_dataMemoryOUt_out, alu3_out_out,
										rd_out_out, ex_alu2_out_out, ex_branchN_out, ex_branchZ_out, ex_jump_out, ex_PCtoReg_out, ex_memtoReg_out, ex_nFlagOut, ex_zFlagOut, clock);

	mux test11(alu3_out_out, ex_dataMemoryOut_out, ex_alu2_out_out, ex_PCtoReg_out, ex_memtoReg_out, mux2_out);
	
	wire and1_out;
	and_gate test12(ex_nFlag_out, ex_branchN_out, and1_out);
	
	wire and2_out;
	and_gate test13(ex_zflag_out, ex_branchZ_out, and2_out);

	or_gate test14(and1_out, and2_out, ex_jump_out, or1_out);

endmodule