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
	wire [31:0] pc_increment;
	wire [31:0] rs_val;
    wire pc_src;
	wire ex_jumpMem_out;
	wire [31:0] pc_mux_out;
	wire aluZ, aluN;
	
	wire [31:0] PCOut;
	reg clock;
	
	//INSTRUCTION FETCH STAGE____________________
	   mux test(pc_increment,rsOut , pc_src, pc_mux_out); //very 1st mux before PC
	   program_counter test1(pc_mux_out, PCOut, clock); //unsure of which module module alu

	wire N, Z;
	
	//PC adder output: pc_increment
	alu test1_5(PCOut, 1, 4'b0100, pc_increment, N, Z); //PC = PC+1 CHANGE TO ADDER??
	
	initial
	begin
		clock = 0;
		forever #5 clock = ~clock;
	end

	wire [31:0] im_out; //instruction memory out
	
	//instruction memory output: im_out
	inst_mem test2(PCOut, clock, im_out);
	
	wire [31:0] if_im_out; //inst fetch inst mem out
	wire [31:0] if_PCOut;
	
	//IF/ID buffer output: if_im_out, if_PCOut 
	ifid_buffer test3(clock, im_out, PCOut, if_im_out, if_PCOut);
	
	//INSTRUCTION DECODE STAGE____________________
	wire [31:0] signOut;
	
	//Sign extension output: signOut
	sign_extender test4(if_im_out[31:28], if_im_out[21:0], signOut); 

	wire [31:0] rsOut;
	wire [31:0] rtOut;
	wire [31:0] data_write;
	wire [31:0] ex_regWrite_out;
	
	
	//PROBLEM: Reset not initialized. Ask what it is for reg_file.v
	reg_file test5(clock, if_im_out[21:16], if_im_out[15:10], ex_rd_out, ex_regWrite_out, ex_regWrite, rsOut, rtOut); 
	
	wire [3:0] aluOp; 
	wire regWrite, memtoReg, PCtoReg, jump, memRead, memWrite, jumpMem, branchz, branchn;
	
	//Control output: regWrite, aluSrc, memtoReg, memRead, memWrite, branch, PCtoReg, jump, aluOp
	control test6(if_im_out[31:28], clock, regWrite, aluSrc, memtoReg, memRead, memWrite, branchz, PCtoReg, jump, branchn, aluOp);
	
	//GETING PC_SRC AS OUTPUT
	wire and1_out;
	and_gate test12(branchz, aluZ, and1_out);
	
	wire and2_out;
	and_gate test13(branchn, aluN, and2_out);
	
	wire or1_out;
	or_gate test14(and1_out, and2_out, or1_out, clock);
	
	wire or2_out;
	or_gate test15(or1_out, jump, pc_src, clock);
	
	//Used for outputs in idex_buffer
	wire [31:0] rsOut_out;
	wire [31:0] rtOut_out;
	wire [5:0] rd_out;
	//wire [31:0] alu2_out_out;
	wire [3:0] aluOp_out;
	wire [31:0] PCOut_Out, signOut_Out;
	wire memRead_out, memWrite_out, PCtoReg_out, memtoReg_out, regWrite_out, jumpMem_out, aluSrcOut;
    
    //ID/EX Buffer outputs: rd_out, rsOut_out, rtOut_out, PCOut_Out, regWrite_out, memtoReg_out, aluOp_out, memRead_out, memWrite_out, PCtoReg_out, aluSrcOut, signOut_Out
	idex_buffer test7(clock, if_im_out[27:22], rsOut, rtOut, if_PCOut, regWrite, memtoReg, aluOp, memRead, memWrite, PCtoReg, aluSrc, signOut,
									rd_out, rsOut_out, rtOut_out, PCOut_Out, regWrite_out, memtoReg_out, aluOp_out, memRead_out, memWrite_out, PCtoReg_out, aluSrcOut, signOut_Out);
	
	//EXECUTION STAGE____________________
	wire [31:0] dataMemoryOut;
	wire [31:0] aluInput1, aluInput2;
	
	//First alu Input Mux output: aluInput1
	mux test17(rsOut_out, PCOut_Out, PCtoReg_out, aluInput1);
	
	//Second alu Input Mux output: aluInput2
	mux test18(rtOut_out, signOut_Out, aluSrcOut, aluInput2);
	
	wire [31:0] aluOut; 
	
	//ALU output: aluZ, aluN, aluOut
	alu test9(aluInput1, aluInput2, aluOp_out, aluOut, aluN, aluZ);
	
	//data memory output: dataMemoryOut
	data_mem test8(clock, memWrite_out, memRead_out, rsOut_out, rtOut_out, dataMemoryOut);

	wire [31:0] ex_alu_out, ex_dataMem_out;
	wire [5:0] ex_rd_out;
	wire ex_memtoReg_out, ex_regWrite;
	
	//WRITE BACK STAGE____________________
	exwb_buffer test10(clock, dataMemoryOut, aluOut, regWrite_out, memtoReg_out, rd_out,
						ex_dataMem_out, ex_alu_out, ex_regWrite, ex_memtoReg_out, ex_rd_out);
	
	//WB Mux output: ex_regWrite_out
	mux test11(ex_alu_out, ex_dataMem_out, ex_memtoReg_out, ex_regWrite_out);
	

endmodule