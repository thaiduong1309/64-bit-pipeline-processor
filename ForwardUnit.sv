`timescale 1ns/10ps

module ForwardUnit (instruction, ReadRegister1, ReadRegister2, ExMemRd, MemWBRd,ExRegWrite, MemRegWrite, MemWri ,ForwardA, ForwardB, ForwardMem);
	input logic [31:0]instruction;
	input logic [4:0]ReadRegister1, ReadRegister2, ExMemRd, MemWBRd;
	input logic ExRegWrite, MemRegWrite, MemWri;
	output logic [1:0]ForwardA, ForwardB,ForwardMem;

	
	always_comb begin
		//Test if there's data hazard for Register A 
		// Forwarding value to Register A from ExMem stage
		if (ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister1))
			ForwardA = 2'b10;
		
	   // Forwarding value to Register A from MemWB stage
		else if (MemRegWrite && (MemWBRd != 5'b11111) && (MemWBRd == ReadRegister1)
		&& !(ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister1)))
			ForwardA = 2'b01;
			
		//No forwarding
		else
			ForwardA = 2'b00;
		
		
		//Test if there's data hazard for Register B (Addi and Subi no forwarding) 
		// Forwarding value to Register B from ExMem stage
		if (ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister2) && !MemWri 
		&& !((instruction[31:22] == 10'b1001000100) || (instruction[31:22] == 10'b1101000100)))
			ForwardB = 2'b10;
					
		// Forwarding value to Register B from MemWB stage
		else if (MemRegWrite && (MemWBRd != 5'b11111) && (MemWBRd == ReadRegister2)
		&& !(ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister2))
		//not ADDI or SUBI
		&& !((instruction[31:22] == 10'b1001000100) || (instruction[31:22] == 10'b1101000100))
		//not STUR or LUDR
		&& !((instruction[31:21] == 11'b11111000000) || (instruction[31:21] == 11'b11111000010)))
			ForwardB = 2'b01;
			
		//No forwarding
		else
			ForwardB = 2'b00;
	
		if (ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister2) && (MemWri || (instruction[31:24]==8'b10110100)))
			ForwardMem = 2'b10;
		else if (MemRegWrite && (MemWBRd != 5'b11111) && (MemWBRd == ReadRegister2) 
		&& !(ExRegWrite && (ExMemRd != 5'b11111) && (ExMemRd == ReadRegister2))
		&& (MemWri || (instruction[31:24]==8'b10110100)))
			ForwardMem = 2'b01;
		else
			ForwardMem = 2'b00;
	end
	
	endmodule

