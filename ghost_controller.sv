module ghost_controller (
    input logic clk, clk2,
    input logic reset,
    input logic [4:0] pacman_x, // Pac-Man's X coordinate
    input logic [4:0] pacman_y, // Pac-Man's Y coordinate
    output logic [4:0] ghost_x, // Ghost's X coordinate
    output logic [4:0] ghost_y  // Ghost's Y coordinate
);

	logic [20:0] row_pixels, row_pixels_up, row_pixels_down;
	
	 
    // ROM to store the wall locations (1 for wall, 0 for no wall)
    GameBoard brd (ghost_y, clk, row_pixels);
	 GameBoard brdu (ghost_y - 1, clk, row_pixels_up);
	 GameBoard brdd (ghost_y + 1, clk, row_pixels_down);
	 


    // State machine to control ghost movement
    enum {
        IDLE,
        MOVE_UP,
        MOVE_DOWN,
        MOVE_LEFT,
        MOVE_RIGHT
    } current_state, next_state;

    // Ghost's current coordinates
    logic [4:0] next_ghost_x, next_ghost_y;

    // Sequential logic for state transitions
    always_ff @(posedge clk2 or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            ghost_x <= 10;
            ghost_y <= 7;
        end else begin
            current_state <= next_state;
            ghost_x <= next_ghost_x;
            ghost_y <= next_ghost_y;
        end
    end

    // Combinational logic for next state and outputs
    always_comb begin
        // Default next state is the current state
        next_state = current_state;
        next_ghost_x = ghost_x;
        next_ghost_y = ghost_y;

        // Movement decision based on Pac-Man's position and wall presence
        if (ghost_x < pacman_x && row_pixels[ghost_x + 1] == 0) begin
				next_state = MOVE_RIGHT;
				next_ghost_x = ghost_x + 1;
        end else if (ghost_x > pacman_x && row_pixels[ghost_x - 1] == 0) begin
				next_state = MOVE_LEFT;
				next_ghost_x = ghost_x - 1;
        end else if (ghost_y > pacman_y && row_pixels_up[ghost_x] == 0) begin
				next_state = MOVE_UP;
				next_ghost_y = ghost_y - 1;
        end else if (ghost_y < pacman_y && row_pixels_down[ghost_x] == 0) begin
				next_state = MOVE_DOWN;
				next_ghost_y = ghost_y + 1;
        end else begin
            next_state = IDLE;
        end
    end

endmodule
