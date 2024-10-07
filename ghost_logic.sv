module ghost_logic(clk, pac_x, pac_y, ghost_x, ghost_y, ghost_left, ghost_right, ghost_up, ghost_down);
	input logic clk;
	input logic [4:0] pac_x, pac_y, ghost_x, ghost_y;
	output logic ghost_left, ghost_right, ghost_up, ghost_down;
	
	logic spawn_move;
	logic pacx_gt_ghostx;
	logic pacy_gt_ghosty;
	
	
// Testing section 	
/*********************************************************************/	
/*********************************************************************/	
	logic [4:0] local_pac_x, local_pac_y, local_ghost_x, local_ghost_y;
	logic pac_samelevelx, pac_samelevely;
	// Variables for testing 
//	logic done;
	// assign done = (local_ghost_x == pac_x) && (local_ghost_y == pac_y);
/*********************************************************************/	
/*********************************************************************/	

	assign spawn_move = ((ghost_x == 10) & (ghost_y == 10)) | ((ghost_x == 10) & (ghost_y == 11));

	// Is pacman to the left or right of the ghost
	assign pacx_gt_ghostx = (pac_x > ghost_x);
	assign pac_samelevelx = (pac_x == ghost_x);
	// Is the pacman above or below the ghost
	assign pacy_gt_ghosty = (pac_y > ghost_y);
	assign pac_samelevely = (pac_y == ghost_y);
	
	always_ff @(posedge clk) begin
//		if (start) begin
//			local_ghost_x = ghost_x;
//			local_ghost_y = ghost_y;
//		end
		if (spawn_move) begin
			ghost_left <= 0;
			ghost_right <= 0;
			ghost_up <= 1;
			ghost_down <= 0;
//			local_ghost_y <= local_ghost_y - 1;

//			local_pac_x <= pac_x;
//			local_pac_y <= pac_y;
//			local_ghost_x <= ghost_x;
//			local_ghost_y <= ghost_y;
		end
		// Move right
		else if (pacx_gt_ghostx | (pacx_gt_ghostx & pac_samelevely)) begin
			ghost_left <= 0;
			ghost_right <= 1;
			ghost_up <= 0;
			ghost_down <= 0;
//			ghost_x <= ghost_x + 1;
		end
		// Move left
		else if (~pacx_gt_ghostx | (~pacx_gt_ghostx & pac_samelevely)) begin
			ghost_left = 1;
			ghost_right = 0;
			ghost_up = 0;
			ghost_down = 0;
//			ghost_x <= ghost_x - 1;
		end
		// Move down
		else if (pacy_gt_ghosty | (pacy_gt_ghosty & pac_samelevelx)) begin
			ghost_up <= 0;
			ghost_down <= 1;
			ghost_left <= 0;
			ghost_right <= 0;
//			ghost_y <= ghost_y + 1;
		end
		// Move up
		else if (~pacy_gt_ghosty | (~pacy_gt_ghosty & pac_samelevelx)) begin
			ghost_up <= 1;
			ghost_down <= 0;
			ghost_left <= 0;
			ghost_right <= 0;
//			ghost_y <= ghost_y - 1;

		end 
	end
endmodule
