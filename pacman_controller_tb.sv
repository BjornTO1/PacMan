`timescale 1 ps / 1 ps

module pacman_controller_tb();
	logic clk, clk2, reset;
	logic up, down, left, right;
	logic [4:0] curr_x, curr_y;
	
	pacman_controller dut(.*);
	assign clk2 = clk;
	// create simulated clock
	parameter T = 20;
	initial begin
		clk <= 0;
		forever #(T/2) clk <= ~clk;
	end  // clock initial
	
	initial begin
	
	reset <= 1; 
	up = 0;
   down = 0;
   left = 0;
   right = 0;@(posedge clk);
	reset <= 0; @(posedge clk);
	
//	repeat(100); @(posedge clk);
	left <= 1; repeat(5) @(posedge clk);
	left <= 0; @(posedge clk);
	@(posedge clk);
	up <= 1; @(posedge clk);
	up <= 0; @(posedge clk);
	down <= 1; @(posedge clk);
	down <= 0; @(posedge clk);
	@(posedge clk);

	right <= 1; @(posedge clk);
	right <= 0; @(posedge clk);
	@(posedge clk);
	
	$stop;
	
	end 
endmodule 
	
	
