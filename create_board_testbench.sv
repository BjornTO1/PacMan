`timescale 1 ps / 1 ps

module create_board_testbench ();
	
	logic clk, gameover;
	logic [9:0] x;
	logic [8:0] y;
	logic back_on;
	
	create_board dut (clk, gameover, x, y, back_on);
	
	// create simulated clock
	parameter T = 20;
	initial begin
		clk <= 0;
		forever #(T/2) clk <= ~clk;
	end  // clock initial
	
	initial begin
		
		gameover <= 0; x <= 90; y <= 10; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		x <= 200; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		gameover <= 1; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule
		
	