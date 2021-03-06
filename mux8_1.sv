module mux8_1(sel,in,out);

	input logic [2:0]sel;
	input logic [7:0]in;
	output logic out;
	
	logic [1:0]tempout;
	
	
	mux4_1 m1(sel[1:0], in[3:0], tempout[0]);
	mux4_1 m2(sel[1:0], in[7:4], tempout[1]);
	mux2_1 m3(sel[2], tempout, out);
	
	

endmodule
