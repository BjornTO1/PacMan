module gameover (clk, reset, pac_x, pac_y, ghost_x, ghost_y, gameover);

	input logic clk, reset;
	input logic [4:0] pac_x, pac_y, ghost_x, ghost_y;
	output logic gameover;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			gameover <= 0;
		else if ((pac_x == ghost_x) && (pac_y == ghost_y))
			gameover <= 1;
		else 
			gameover <= gameover;
	end
endmodule
	