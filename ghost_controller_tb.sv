`timescale 1 ps / 1 ps

module ghost_controller_tb();
	logic clk, clk2;
   logic reset;
   logic [4:0] pacman_x; // Pac-Man's X coordinate
   logic [4:0] pacman_y; // Pac-Man's Y coordinate
   logic [4:0] ghost_x;	 // Ghost's X coordinate
   logic [4:0] ghost_y;  // Ghost's Y coordinate
	
	ghost_controller dut (.*);
	
	assign clk2 = clk;
	// create simulated clock
	parameter T = 20;
	initial begin
		clk <= 0;
		forever #(T/2) clk <= ~clk;
	end  // clock initial
	
	initial begin
	reset <= 1; pacman_x <= 4'b0001; pacman_y <= 4'b0001; @(posedge clk);
	reset <= 0; @(posedge clk);
	
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	pacman_x <= 4'b0001; pacman_y <= 4'b0101; @(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	$stop;
	end
endmodule 
