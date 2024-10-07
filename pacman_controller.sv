module pacman_controller (clk, clk2, reset, up, down, left, right, curr_x, curr_y);

		input logic clk, clk2, reset;
		input logic up, down, left, right;
		output logic [4:0] curr_x, curr_y;
		
		logic [20:0] row_pixels, minrow_pixels, maxrow_pixels;
		logic [4:0] y;
		logic up1, down1, left1, right1;
		
		GameBoard board (y, clk, row_pixels);
		GameBoard boardabove ((y - 1), clk, maxrow_pixels);
		GameBoard boardbelow ((y + 1), clk, minrow_pixels);

		
		// set output location
		always_ff @(posedge clk2 or posedge reset) begin
			if (reset) begin
				curr_x <= 10;
				curr_y <= 12;
			end
			else begin
				if (up & ~down & ~right & ~left) begin
					if (row_pixels[curr_x])
						curr_y <= curr_y;
					else
						curr_y <= curr_y - 1;
					end
				else if (~up & down & ~right & ~left) begin
					if (row_pixels[curr_x])
						curr_y <= curr_y;
					else
						curr_y <= curr_y + 1;
				end
				else if (~up & ~down & ~right & left) begin
					if (row_pixels[curr_x - 1])
						curr_x <= curr_x;
					else
						curr_x <= curr_x - 1;
				end
				else if (~up & ~down & right & ~left) begin
					if (row_pixels[curr_x +1])
						curr_x <= curr_x;
					else 
						curr_x <= curr_x + 1;
				end
				else begin
					curr_x <= curr_x;
					curr_y <= curr_y;
				end
			end
		end
		
// 		always_comb begin
// 		    if (up & ~down) y = curr_y + 1;
// 		    if (down & ~up) y = curr_y - 1;
// 		    else y = curr_y;
// 		end
// 		find the potential value of next x and next y
		always_ff @(posedge clk) begin
			if (up)
				y <= curr_y - 1;
			else if (down) 
				y <= curr_y + 1;
			else begin
			y <= curr_y;
			end
		end
		
		// flip flip to sync input
		always_ff @(posedge clk) begin
			up1 <= up;
			down1 <= down;
			left1 <= left;
			right1 <= right;
		end
		
	endmodule
