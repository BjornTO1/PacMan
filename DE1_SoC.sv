module DE1_SoC (V_GPIO,
					 CLOCK_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);

	input CLOCK_50;
	inout [35:0] V_GPIO;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;

	logic reset;
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	logic up, down, left, right, select, start, A, B;
	logic g_up, g_down, g_left, g_right;

	logic back_on;
	logic pac_on, ghost_on;
	logic [4:0] pac_x, pac_y, ghost_x, ghost_y;
	logic gameover;
	
	video_driver #(.WIDTH(640), .HEIGHT(480))
		v1 (.CLOCK_50, .reset, .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
			 
	logic done;
	
	create_board bout (CLOCK_50, gameover, x, y, back_on);
	
	// Pacman controlling logic 
	n8_driver n8 (CLOCK_50, V_GPIO[28], V_GPIO[26], V_GPIO[27], 
					  up, down, left, right, select, start, A, B);	
	pacman_controller p_unit (CLOCK_50, PAC_CLOCK, reset, up, down, left, 
									  right, pac_x, pac_y);
	// Ghost controlling logic 
	//ghost_logic g_logic(CLOCK_50, pac_x, pac_y, ghost_x, ghost_y,
	//							g_left, g_right, g_up, g_down);	
	ghost_controller p_control (CLOCK_50, GHOST_CLOCK, reset, pac_x, pac_y,
										 ghost_x, ghost_y);
									  
	// Draw pac and ghost								  
	create_ghost ghost (CLOCK_50, gameover, x, y, ghost_x, ghost_y, ghost_on);
	create_pacman pac (CLOCK_50, gameover, x, y, pac_x, pac_y, pac_on);
	
	// game over logic
	gameover gover (CLOCK_50, reset, pac_x, pac_y, ghost_x, ghost_y, gameover);
	
	clock_divider c1 (.clock(CLOCK_50), .divided_clocks(clk));
	logic [31:0] clk;
	logic PAC_CLOCK;
	logic GHOST_CLOCK;
	assign PAC_CLOCK = clk[23];
	assign GHOST_CLOCK = clk[24];
	
	// need to assign the actual pixel value of pacman (this is the center
	// value of the square that pacman is currently in)
	always_comb  begin
		if (back_on) begin
			r = 8'd0;
			g = 8'd0;
			b = 8'd255;
		end
		else if (pac_on) begin
			r = 8'd255;
			g = 8'd255;
			b = 8'd0;
		end
		else if (ghost_on) begin
			r = 8'd255;
			g = 8'd0;
			b = 8'd0;
		end
		else begin
			r = 8'd0;
			g = 8'd0;
			b = 8'd0;
		end
	end
		
	assign reset = start;
	
endmodule  // DE1_SoC


`timescale 1 ps / 1 ps
module DE1_SoC_testbench ();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [35:0] V_GPIO;
	logic [9:0] LEDR, SW;
	logic [3:0] KEY;
	logic CLOCK_50;
	logic [7:0] VGA_R, VGA_G, VGA_B;
	logic VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
	
	// instantiate module
	DE1_SoC dut (.*);
	
	// create simulated clock
	parameter T = 20;
	initial begin
		CLOCK_50 <= 0;
		forever #(T/2) CLOCK_50 <= ~CLOCK_50;
	end  // clock initial
	
	// simulated inputs
	initial begin
		
		$stop();
	end  // inputs initial
	
endmodule  // DE1_SoC_testbench
