module DFF_5bit (q, clk, reset, data);
	input logic [4:0] data;
	input logic clk, reset;
	output logic [4:0]q;

	//logic [4:0]reData;
	genvar i;
 
 generate
	for(i=0; i<5; i++) begin : eachDff
 
		D_FF d1 (q[i], data[i], reset, clk);
		
	end
 
 endgenerate
 endmodule