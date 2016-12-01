//D_FF of the control unit that are used 2 clock later

`timescale 1 ps / 100 fs

module D_FF1 (out, in, reset, clk);
	
	input logic clk,reset,in;
	output logic out;
	
	logic d,q;
	D_FF d1 (q, in, reset, clk);
	D_FF d2 (out, q, reset, clk);

endmodule

module D_FF1_testbench();

	logic out,in,reset,clk;

	D_FF1 dut (out,in,reset,clk);

	parameter CLOCK_PERIOD  = 2500; 

initial begin
clk <= 0; 

//clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end


	initial begin
	reset <= 1;								@(posedge clk);
												@(posedge clk); 
	reset <= 0; in <=1  ; 							@(posedge clk);
	in <=0 ;@(posedge clk);
	@(posedge clk);
	in <=1; @(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	in <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
$stop ;
end
endmodule
