`timescale 1 ps / 100 fs

module mux64_4_1 (sel, in0, in1, in2, in3, out);
	input logic [1:0] sel;
	input logic [63:0] in0, in1, in2, in3;
	output logic [63:0]out;
	
	logic [63:0]selout0,selout1;
	
	mux64_2_1 m1 (sel[0], in0, in1, selout0);
	mux64_2_1 m2 (sel[0], in2, in3, selout1);
	mux64_2_1 m3 (sel[1], selout0, selout1, out);
	
endmodule