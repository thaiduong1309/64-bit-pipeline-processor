`timescale 1ns/10ps

module CPU(clk, reset);
	input logic clk, reset;
	
	//regfile
	logic [63:0]WriteData1, WriteData;
	logic [4:0]ReadRegister1, ReadRegister2, WriteRegister;
	logic [63:0]ReadData1, ReadData2;
	logic enRegWrite, enWriteRd;
	logic [4:0]RegRd0, RegRd;
	logic [63:0]Db;
	
	//Forwading UniT
	logic [4:0] ExMemRd, MemWBRd;
	logic ExRegWrite, MemRegWrite;
	logic [1:0]ForwardA, ForwardB, ForwardMem;
	
	
	//ALU
	logic	[2:0]		cntrl;
	logic	[63:0]	A, B, result;
	logic	negative, zero, overflow, carry_out;
	logic [3:0] flag;
	//for pipeline DFF
	logic [63:0]	finalA,finalB;
	logic en_Flag;
	
	
	//instrumem
	logic	[31:0]	instruction, instruct;
	logic	[63:0]	PC,PC_result,PC1,PCadd4;
	logic [63:0] PCAdd40,PCAdd41,PCAdd42;
	
	//datamem
	logic	write_enable;
	logic	read_enable;
	logic [63:0]   address;
	logic	[63:0]	write_data,write_data0, write_data1;
	logic	[63:0]	read_data;
	logic MemWE, Mem2Reg;
	//pipeline
	logic [63:0] data2reg;
	logic [3:0]notuse;
	
	//control
	logic Reg2Loc, ALUsrc, MemtoReg, RegWrite, MemWri, BrTaken, UncondBr, Readmem, ALUsrc1, enFlags, WriteRd, BR;
	logic [2:0]ALUOp;
	logic [63:0]DAddr9, CondAddr19, BrAddr26, Imm12, ALUsrc_re,shit;
	//For pipeline dff
	logic [63:0]PClater;
	logic q, Dbzero, Taken;
	
	/*************************************************************/
	/*********************INSTRUCTION_MEM(PC)*********************/
	/*************************************************************/
	
	

	//get the instruction from instruction memory
	D_FF branch (q,BrTaken,reset,clk);
	
	alu add0 (PC,64'd4,3'b010,PCadd4,notuse[0],notuse[1],notuse[2],notuse[3]);
	mux64_2_1 pickpc (Taken, PCadd4, PC1, PC_result);
	DFF_VAR cp (1'b1, PC, clk, reset, PC_result);
	
	instructmem ins (PC,instruct,clk);
	PCControl pcc (instruct, Dbzero, flag , BrTaken);
	
	PCBrControl pcbc (instruction, q, Dbzero, flag[0], flag[2], Taken);
	//Program counter
	
	
	/***************************IF/ID*****************************/
	DFF_32bit ins1 (1'b1,instruction, clk, reset, instruct);
	DFF_VAR pctoreg (1'b1,PClater,clk,reset,PC);
	
	DFF_VAR pcadd4toreg0 (1'b1, PCAdd40, clk, reset, PCadd4);
	/*************************************************************/
	
	
	calPC cal (PClater,PC1, CondAddr19, BrAddr26, ReadData2, UncondBr, BR);
	
	/*************************************************************/
	/***********************CONTROL SIGNAL***********************/
	/*************************************************************/
	//CONTROL: run the instruction through the control signal

	Control c1 (instruction, Reg2Loc, ALUsrc, MemtoReg, RegWrite,
	MemWri, ALUOp, Readmem, ALUsrc1, enFlags, WriteRd, UncondBr, BR);
	
	//negative is bit0 of flag
	//zero is bit 1 of flag
	// overflow is bit 2 of flag
	//carry_out is bit 3 of flag
	
	//sign-extend result
	SignExtend SE (instruction, DAddr9, Imm12, CondAddr19, BrAddr26);
	
	/*************************************************************/
	/***************************REGFILE***************************/
	/*************************************************************/
	
	
	//REGFILE: Rd,Rn,Rm, RegWrite, Reg2Loc, Da, Db
	
	
	
	assign ReadRegister1 = instruction[9:5];
	
	mux5_2_1 mRD (Reg2Loc,instruction[4:0],instruction[20:16],ReadRegister2);
	
	mux5_2_1 mWR (WriteRd, 5'b11110, instruction[4:0], RegRd);
	
	regfile r (ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 enRegWrite, ~clk,reset);
					 
	ZeroFlag testDb (Dbzero,write_data0);
	
	mux64_2_1 m3 (ALUsrc1, DAddr9, Imm12, ALUsrc_re);
	mux64_2_1 m4 (ALUsrc, ReadData2, ALUsrc_re, Db );				 
	/*************************************************************/
	/**********************FORWARDING-UNIT************************/
	/*************************************************************/

	//00 no Forwarding
	//01 Forward from Mem (Mem hazard)
	//10 Forward from Ex  (Ex hazard)
	//Forward result to ReadRegister 2 if forwardmem = 1 
	ForwardUnit foward (instruction, ReadRegister1, ReadRegister2, ExMemRd, MemWBRd,ExRegWrite, MemRegWrite, MemWri ,ForwardA, ForwardB, ForwardMem);
	
	mux64_4_1 pickA (.sel(ForwardA),.in0(ReadData1),.in1(data2reg),.in2(result),.in3(64'b0),.out(finalA));
	mux64_4_1 pickB (.sel(ForwardB),.in0(Db)		  ,.in1(data2reg),.in2(result),.in3(64'b0),.out(finalB));
	mux64_4_1 pickmem (ForwardMem, ReadData2, data2reg, result, 64'b0,write_data0 );
	
	//mux64_2_1 pickdatamem (.sel(ForwardMem), .in0(ReadData2) ,.in1(data2reg),.in2(result),.in3(64'b0),.out(finalB));
	/************************ID/EX*********************************/
	
	DFF_VAR a (.en(1'b1),.q(A), .clk(clk), .reset(reset), .data(finalA));
	DFF_VAR b (.en(1'b1),.q(B), .clk(clk), .reset(reset), .data(finalB));
	DFF_VAR pcadd4toreg1 (1'b1,PCAdd41,clk,reset,PCAdd40);
	DFF_VAR memdata0 (.en(1'b1),.q(write_data1), .clk(clk), .reset(reset), .data(write_data0));
	
	D_FF aluop0 (.q(cntrl[0]), .d(ALUOp[0]), .reset(reset), .clk(clk));
	D_FF aluop1 (.q(cntrl[1]), .d(ALUOp[1]), .reset(reset), .clk(clk));
	D_FF aluop2 (.q(cntrl[2]), .d(ALUOp[2]), .reset(reset), .clk(clk));
	D_FF enf (.q(en_Flag),.d(enFlags),.reset(reset),.clk(clk));
	D_FF regW0 (.q(ExRegWrite), .d(RegWrite), .reset(reset), .clk(clk)); 
	
	DFF_5bit rd0 (.q(ExMemRd), .clk(clk), .reset(reset), .data(RegRd));
	
	/*************************************************************/
	
	
	/*************************************************************/
	/************************EXECUTION ALU************************/
	/*************************************************************/
	
	//Execution step
	
	alu exc (A, B, cntrl, result, negative, zero, overflow, carry_out);
	
	flags fl (en_Flag, negative,zero,overflow,carry_out, reset, ~clk, flag);
	
	/****************************EX/MEM***************************/
	D_FF regW1 (.q(MemRegWrite), .d(ExRegWrite), .reset(reset), .clk(clk)); 
	
	DFF_5bit rd1 (.q(MemWBRd), .clk(clk), .reset(reset), .data(ExMemRd));
	
	D_FF1	m2r (.out(Mem2Reg)    ,.in(MemtoReg), .reset(reset), .clk(clk));
	D_FF1 mwe (.out(MemWE)      ,.in(MemWri)	, .reset(reset), .clk(clk));
	D_FF1 rm  (.out(read_enable),.in(Readmem)	, .reset(reset), .clk(clk));
	D_FF1 wrd (.out(enWriteRd)	 ,.in(WriteRd)	, .reset(reset), .clk(clk));
	
	DFF_VAR addr (.en(1'b1), .q(address), .clk(clk), .reset(reset), .data(result));
	DFF_VAR memdata (.en(1'b1),.q(write_data), .clk(clk), .reset(reset), .data(write_data1));
	DFF_VAR pcadd4toreg2 (1'b1,PCAdd42,clk,reset,PCAdd41);
	
	/*************************************************************/
	/***************************DATAMEM***************************/
	/*************************************************************/
	
	// Pick between datamem and result from ALU
	mux64_2_1 m5(Mem2Reg, address, read_data, WriteData1);
	// Pick if store PC or WriteData into Rd;
	mux64_2_1 m6 (enWriteRd, PCAdd42, WriteData1, data2reg );//not finish
	
	//get the data from datamemmory result of the ALU
	
	/*assign write_data = ReadData2;
	/*assign write_enable = MemWri;
	assign read_enable = Readmem;*/
	
	datamem da (address, MemWE, read_enable, write_data, clk, 4'd8, read_data);
	
	/*************************MEM/WB******************************/
	D_FF regW2 (.q(enRegWrite), .d(MemRegWrite), .reset(reset), .clk(clk));  	
	
	DFF_5bit rd2 (.q(WriteRegister), .clk(clk), .reset(reset), .data(MemWBRd));
	
	DFF_VAR d2r (.en(1'b1),.q(WriteData), .clk(clk), .reset(reset), .data(data2reg));

	
endmodule






`timescale 1ns/10ps

module CPU_testbench ();
	logic clk,reset;
	CPU dut (clk, reset);

parameter CLOCK_PERIOD  = 500; 

initial begin
clk <= 0; 

//clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end

initial begin 
reset <= 1;								@(posedge clk);
											@(posedge clk); 
reset <= 0;   							@(posedge clk);
											@(posedge clk); 
repeat(1200)	begin										@(posedge clk); end
	



$stop ; // End Simulation 
end  
endmodule