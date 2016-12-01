`timescale 1 ps / 100 fs

module SignExtendPc (instr, CondAddr19, BrAddr26);

	input logic [31:0]instr;
	output logic [63:0] CondAddr19, BrAddr26;
	
	
	
	integer i,j,k,l;
	
	always_comb begin
	
	CondAddr19[18:0]= instr[23:5];
	BrAddr26[25:0]= instr[25:0];
	

	for (j=19; j<64; j++) begin
		CondAddr19[j]=instr[23];
	end
	
	for (k=26; k<64; k++) begin
		BrAddr26[k]=instr[25];
	end
	
	end
	
endmodule
