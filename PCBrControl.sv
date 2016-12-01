module PCBrControl (instr, q, Dbzero,negative, overflow, Taken);
	input logic [31:0]instr;
	input logic q, Dbzero,negative, overflow;
	output logic Taken;
	
		always_comb begin
	casex (instr[31:21])
	//ADDS: 558
	11'b10101011000: begin
		Taken	= q;
	end
	//ADDI: 244
	11'b1001000100x: begin
		Taken	= q;
	end
	//SUBI: 344
	11'b1101000100x: begin
		Taken	= q;
	end
	//SUBS: 758
	11'b11101011000: begin
		Taken	= q;
	end
	//LDUR: 7C0
	11'b11111000010: begin
		Taken	= q;
	end
	//STUR: 7C2
	11'b11111000000: begin
		Taken	= q;
	end
	//B: 54
	11'b000101xxxxx: begin
		Taken	= q;
	end
	//CBZ: B4
	11'b10110100xxx: begin
		Taken	= q & Dbzero;
	end
	
	//B.LT
	11'b01010100xxx: begin
		Taken  = q & (negative^overflow) ;
	end
	
	//BL: 
	11'b100101xxxxx: begin
		Taken	= q;
	end
	
	//BR
	11'b11010110000: begin
		Taken	= q;
	end
//
	default begin
		Taken	= 1'b0;
	end
	endcase
	end
	
endmodule	

	