`timescale 1 ps / 100 fs

module enDecoder5_32(en,in,out);
	input logic en;
	input logic [4:0]in;
	output logic [31:0]out;
	
	logic [1:0]enout;
	enDecoder1_2 n1(en,in[4],enout);
	
	enDecoder4_16 a1(enout[0],in[3:0],out[15:0]);
	enDecoder4_16 a2(enout[1],in[3:0],out[31:16]);
	
endmodule