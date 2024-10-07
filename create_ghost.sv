module create_ghost (clk, gameover, x, y, ghost_x, ghost_y, ghost_on);

	input logic clk, gameover; 
	input logic [9:0] x;
	input logic [8:0] y;
	input logic [4:0] ghost_x, ghost_y;
	output logic ghost_on;
	
	logic [5:0] sprite_x, sprite_y;
	logic [20:0] pac_pixels [20:0];
	
	assign pac_pixels[0] = 21'b000000000000000000000;
   assign pac_pixels[1] = 21'b000000000000000000000;
   assign pac_pixels[2] = 21'b000000001111100000000;
   assign pac_pixels[3] = 21'b000001111111111100000;
   assign pac_pixels[4] = 21'b000011111111111110000;
   assign pac_pixels[5] = 21'b000011100111111011000;
   assign pac_pixels[6] = 21'b000111000011110011100;
   assign pac_pixels[7] = 21'b000110000001100011100;
   assign pac_pixels[8] = 21'b000110000011100011100;
   assign pac_pixels[9] = 21'b001110001111100011100;
   assign pac_pixels[10] = 21'b001110001111100011100;
   assign pac_pixels[11] = 21'b001111000111110001100;
   assign pac_pixels[12] = 21'b001111101111111001100;
   assign pac_pixels[13] = 21'b001111111111111111100;
   assign pac_pixels[14] = 21'b001111111111111111100;
   assign pac_pixels[15] = 21'b001111111111111111100;
   assign pac_pixels[16] = 21'b001111111111111111100;
   assign pac_pixels[17] = 21'b001111111111111111100;
   assign pac_pixels[18] = 21'b001100111000111001100;
   assign pac_pixels[19] = 21'b000000011000110000000;
   assign pac_pixels[20] = 21'b000000000000000000000;
	
	assign sprite_x = (x-100)%21;
	assign sprite_y = (y-9)%21;

	always_comb begin
		if ((y >= ((ghost_y * 21) + 9)) & (y < (((ghost_y + 1) * 21) + 9)) &
			(x >= ((ghost_x *21) + 100)) & (x < (((ghost_x + 1) * 21) + 100)) &
			(pac_pixels[sprite_y][sprite_x]) & ~gameover)
			ghost_on = 1;
		else 
			ghost_on = 0;
	end
endmodule
