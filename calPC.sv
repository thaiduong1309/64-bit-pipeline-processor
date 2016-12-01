`timescale 1 ps / 100 fs

module calPC (PC,PC_result,CondAddr19, BrAddr26, ReadData2, UncondBr, BR);
	input logic [63:0] PC, CondAddr19, BrAddr26, ReadData2;
	input logic UncondBr, BR;
	output logic [63:0] PC_result;

	logic [63:0] shift_pick, pick;
	logic [63:0] PC1;
	logic [2:0]result, negative, zero, overflow, carry_out;
	
	
	// pick is the value between UncondBr mux
	mux64_2_1 m0 (UncondBr,CondAddr19, BrAddr26, pick);
	
	//shift left by 2 the result from the UncondBr mux  
	shifter s1 (pick, 1'b0, 6'd2, shift_pick);
	
	// PC + 4

	
	// PC + add number
	alu add1 (PC,shift_pick,3'b010,PC1,negative[1],zero[1],overflow[1],carry_out[1]);
	
	//Is it BR
	mux64_2_1 mBR (BR, PC1, ReadData2, PC_result);

	
	//Take the branch or not
	//mux64_2_1 m1 (BrTaken, PCadd4, PC1, PC_result);
	

endmodule