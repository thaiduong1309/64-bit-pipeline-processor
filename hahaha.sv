module Control (instr, zero, Reg2Loc, ALUsrc, MemtoReg, RegWri, MemWri, BrTaken, UncondBr, ALUOp,Readmem);

	input logic [31:0]instr;
	input logic zero;
	output logic [2:0]ALUOp;
	output logic Reg2Loc, MemtoReg, RegWri, MemWri, BrTaken, UncondBr, Readmem;
	output logic [1:0]ALUsrc;
	
	always_comb begin
	casex (instr[31:21])
	//ADDS: 558
	11'b10101011000: begin
		Reg2Loc	= 1'b1;
		ALUsrc	= 2'b10;
		MemtoReg = 1'b0;
		RegWri	= 1'b1;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b010;
		Readmem  = 1'b0;
	end
	//ADDI: 244
	11'b1001000100x: begin
		Reg2Loc	= 1'b0;
		ALUsrc	= 2'b10;
		MemtoReg = 1'b0;
		RegWri	= 1'b1;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b010;
		Readmem  = 1'b0;
	end
	//SUBI: 344
	11'b1101000100x: begin
		Reg2Loc	= 1'b0;
		ALUsrc	= 2'b00;
		MemtoReg = 1'b0;
		RegWri	= 1'b1;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b011;
		Readmem  = 1'b0;
	end
	//SUBS: 758
	11'b11101011000: begin
		Reg2Loc	= 1'b0;
		ALUsrc	= 2'b00;
		MemtoReg = 1'b0;
		RegWri	= 1'b1;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b011;
		Readmem  = 1'b0;
	end
	//LDUR: 7C0
	11'b11111000010: begin
		Reg2Loc	= 1'bX;
		ALUsrc	= 2'b01;
		MemtoReg = 1'b1;
		RegWri	= 1'b1;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b010;
		Readmem  = 1'b1;
	end
	//STUR: 7C2
	11'b11111000000: begin
		Reg2Loc	= 1'b0;
		ALUsrc	= 2'b01;
		MemtoReg = 1'bX;
		RegWri	= 1'b0;
		MemWri	= 1'b1;
		BrTaken	= 1'b0;
		UncondBr = 1'bX;
		ALUOp		= 3'b010;
		Readmem  = 1'b1;
	end
	//B: 54
	11'b000101xxxxx: begin
		Reg2Loc	= 1'bX;
		ALUsrc	= 2'bX;
		MemtoReg = 1'bX;
		RegWri	= 1'b0;
		MemWri	= 1'b0;
		BrTaken	= 1'b1;
		UncondBr = 1'b1;
		ALUOp		= 3'bX;
		Readmem  = 1'bX;
	end
	//CBZ: B4
	11'b10110100xxx: begin
		Reg2Loc	= 1'b0;
		ALUsrc	= 2'b00;
		MemtoReg = 1'bX;
		RegWri	= 1'b0;
		MemWri	= 1'b0;
		BrTaken	= 1'b0;
		UncondBr = zero;
		ALUOp		= 3'b000;
		Readmem	= 1'bX;
	end
	//
	default begin
		Reg2Loc	= 1'bX;
		ALUsrc	= 1'bX;
		MemtoReg = 1'bX;
		RegWri	= 1'bX;
		MemWri	= 1'bX;
		BrTaken	= 1'bX;
		UncondBr = zero;
		ALUOp		= 3'bX;
		Readmem	= 1'bX;
	end
	endcase
	end
endmodule	
