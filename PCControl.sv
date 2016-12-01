`timescale 1 ps / 100 fs

module PCControl (instr, zero, flag , BrTaken);

	input logic [31:0]instr;
	input logic zero;
	input logic [3:0]flag;
	output logic BrTaken;
	
	always_comb begin
	casex (instr[31:21])
	//ADDS: 558
	11'b10101011000: begin
		BrTaken	= 1'b0;
	end
	//ADDI: 244
	11'b1001000100x: begin
		BrTaken	= 1'b0;
	end
	//SUBI: 344
	11'b1101000100x: begin
		BrTaken	= 1'b0;
	end
	//SUBS: 758
	11'b11101011000: begin
		BrTaken	= 1'b0;
	end
	//LDUR: 7C0
	11'b11111000010: begin
		BrTaken	= 1'b0;
	end
	//STUR: 7C2
	11'b11111000000: begin
		BrTaken	= 1'b0;
	end
	//B: 54
	11'b000101xxxxx: begin
		BrTaken	= 1'b1;
	end
	//CBZ: B4
	11'b10110100xxx: begin
		BrTaken	= 1'b1;
	end
	
	//B.LT
	11'b01010100xxx: begin
		BrTaken  = 1'b1;
	end
	
	//BL: 
	11'b100101xxxxx: begin
		BrTaken	= 1'b1;
	end
	
	//BR
	11'b11010110000: begin
		BrTaken	= 1'b1;
	end
//
	default begin
		BrTaken	= 1'bX;
	end
	endcase
	end
	
endmodule	
