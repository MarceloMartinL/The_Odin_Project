class Board

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@current_player = @player1
	end

 # Creates a Hash with 64 nodes using the chess coordinates (e.g. b1) as keys for each node.
	def board_making
		@board = {}
		(1..8).each do |num|	
			("a".."h").each do |letter|
				pair = letter + num.to_s 
				@board[pair] = Node.new
			end
		end
	end

 # Sets each piece on his corresponding initial position on the board.
	def board_setup
		initial_position = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]
		special_position = [8,1]
		pawn_position = [7,2]
		initial_color = ["black","white"]
		i = 0
		x = 0
		special_position.each do |num|
			("a".."h").each do |letter|
				@board[letter+num.to_s].name = initial_position[i]
				@board[letter+num.to_s].color = initial_color[x]
				i += 1
			end
			i = 0
			x += 1
		end

		y = 0
		pawn_position.each do |num|
			("a".."h").each do |letter|
				@board[letter+num.to_s].name = "pawn"
				@board[letter+num.to_s].color = initial_color[y]
			end
			y += 1
		end
	end

 # Creates a grid of 8x8 squares using unicode characters, really sexy.
	def show_board
		top_left       = "\u250c"
		horizontal     = "\u2500"
		top_right      = "\u2510"
		bot_left       = "\u2514"
		bot_right      = "\u2518"
		vertical       = "\u2502"
		cross          = "\u253c"
		top_cross      = "\u252c"
		bot_cross      = "\u2534"
		left_vertical  = "\u251c"
		right_vertical = "\u2524"

		top_board = " " + top_left + (horizontal*3 + top_cross)*7 + horizontal*3 + top_right
		mid_board = vertical + ("   " + vertical)*7 + "   " + vertical
		separator_board = " " + left_vertical + (horizontal*3 + cross)*7 + horizontal*3 + right_vertical
		bot_board = " " + bot_left + (horizontal*3 + bot_cross)*7 + horizontal*3 + bot_right

		puts top_board

		(2..8).reverse_each do |num|
			mid_test = num.to_s + vertical
			("a".."h").each do |letter|
				pair = letter + num.to_s 
				mid_test += " #{@board[pair].view} " + vertical
			end
			puts mid_test
			puts separator_board
		end

		mid_test = 1.to_s + vertical
		("a".."h").each do |letter|
			pair = "#{letter}1"
			mid_test += " #{@board[pair].view} " + vertical
		end

		puts mid_test
		puts bot_board
		puts "   a   b   c   d   e   f   g   h\n"		
	end

  # Validates if the player input has the correct syntax.
	def input_validation
		validation = false
		while validation == false
			puts "\n#{@current_player.name} please enter your move like this: b1 to c3"
			input = gets.chomp.downcase
			@player_play = input.split(" to ")

			if input.length != 8
				puts "\nIncorrect number of characters, please follow this syntax: b1 to c3 (with spaces)"
			elsif !input.include?("to")
				puts "\nIncorrect syntax, please follow this example: b1 to c3 (with spaces)"
			elsif (!("a".."h").include?(@player_play[0][0]) || !("1".."8").include?(@player_play[0][1])) || (!("a".."h").include?(@player_play[1][0]) || !("1".."8").include?(@player_play[1][1]))
				puts "\n¡Error!.The correct syntax for coordinates is Letter (a - h) + Number (1 - 8)"
				puts "For example b1, g2 or f5, please try again!"
			elsif @current_player.color != @board[@player_play[0]].color
				puts "¡Error!.That is not your piece or is an empty square, try again!"
			elsif (@player_play.size == 2 && @current_player.color == @board[@player_play[0]].color) && (@player_play[0].length == 2 && @player_play[1].length == 2)
				validation = true
			end
		end
		input_convertion(@player_play)	
	end


	def input_convertion(input)
		@letter_convertion = {"a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8}
		final_movement = []
		x1 = @letter_convertion[input[0][0]]
		y1 = input[0][1].to_i
		x2 = @letter_convertion[input[1][0]]
		y2 = input[1][1].to_i
		@start_coord = [x1,y1]
		@final_coord = [x2,y2]
		final_movement << (x2 - x1)
		final_movement << (y2 - y1)
		
		movement_validation(final_movement)	
	end

	def movement_validation(player_mov)
		@piece_name = @board[@player_play[0]].name
		@opponent_piece = @board[@player_play[1]].name
		correct_mov = []
		piece_movs = {
			"king"   => [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]],
			"knight" => [[-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1], [2,1], [1,2], [-1,2]],
			"rook"   => [[0,1], [1,0], [0,-1], [-1,0]],
			"bishop" => [[1,1], [1,-1], [-1,-1], [-1,1]],
			"queen"  => [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]],
			"pawn"   =>	[[0,1], [0,-1], [1,1], [-1,1], [0,2], [0,-2]]
		}
		
		if ["king", "knight"].include?(@piece_name)
			piece_movs[@piece_name].each do |mov|
				if mov == player_mov && (@board[@player_play[1]].color != @current_player.color || @board[@player_play[1]].color == nil)
					node_change
				end
			end
			puts "Your piece can't move there, try again!"
			input_validation
		elsif ["rook", "bishop", "queen"].include?(@piece_name)
			piece_movs[@piece_name].each do |mov|
				(1..7).each do |num|
					iteration = [mov[0]*num, mov[1]*num]
					if iteration == player_mov
						#Stores the movement of the piece that allows it reach the endpoint.
						correct_mov = mov
						#If the way is clear then change the nodes.
						if cleared_way?(correct_mov) == true
							node_change
						else
							puts "Error!. Your piece cannot leap over other pieces, try again!"
							input_validation
						end
					end
				end
			end
			puts "Your piece can't move there, try again!"
			input_validation
		elsif @piece_name == "pawn"
			if piece_movs["pawn"][0..1].include?(player_mov) && @board[@player_play[1]].color == nil 
				node_change
			elsif piece_movs["pawn"][2..3].include?(player_mov) && (@board[@player_play[1]].color != @current_player.color && @board[@player_play[1]].color != nil)
				node_change
			elsif piece_movs["pawn"][4] == player_mov && (@board[@player_play[0]].color == "white" && @player_play[0][1] == "2")
				node_change
			elsif piece_movs["pawn"][5] == player_mov && (@board[@player_play[0]].color == "black" && @player_play[0][1] == "7")
				node_change
			else
				puts "Your piece can't move there, try again!"
				input_validation		
			end
		end
	end

 # Checks if the way to the endpoint is clear.
	def cleared_way?(correct_mov)
		while @start_coord != @final_coord
			@start_coord = [@start_coord[0] + correct_mov[0], @start_coord[1] + correct_mov[1]]
			x_new = ""
			y_new = @start_coord[1].to_s
			@letter_convertion.each do |key, value|
				if @start_coord[0] == value
					x_new = key
				end
			end

			@mov_translation = x_new + y_new
	
			if @board[@mov_translation].name != nil && @mov_translation != @player_play[1]
				return false
			elsif @board[@mov_translation].color != @current_player.color && @mov_translation == @player_play[1]
				return true
			end		
		end
	end

	def check_condition
		enemy_position = []
		@board.each do |key, piece|

		end
	end

	def promotion_menu
		puts "       PAWN PROMOTION !!!"
		puts "\nSelect a number to promote your pawn to a class:"
		puts " (1)Queen, (2)Rook, (3)Bishop or (4)Knight\n"
		while @board[@player_play[1]].name == "pawn"
			input = gets.chomp
			if ("1".."4").include?(input)
				case input
				when "1"
					@board[@player_play[1]].name = "queen"
				when "2"
					@board[@player_play[1]].name = "rook"
				when "3"
					@board[@player_play[1]].name = "bishop"
				when "4"
					@board[@player_play[1]].name = "knight"
				end
			else
				puts "\nError! please enter a number 1 - 4"
			end
		end
		@board[@player_play[1]].color = @current_player.color
		change_player
	end

	def promotion_check
		if @player_play[1][1] == "8" && @current_player.color == "white"
			promotion_menu
		elsif @player_play[1][1] == "1" && @current_player.color == "black"
			promotion_menu
		else
			change_player
    end
	end

	def win_condition
		if @opponent_piece == "king"
			show_board
			finish_game
		end
	end

	def finish_game
		puts "The King is DEAD !!!"
		puts "#{@current_player.name} WON THE GAME !!!"
		exit
	end

	def game_conditions
		if @piece_name == "pawn"
			win_condition 
			promotion_check
		else
			win_condition
			change_player
		end
	end

	def node_change
		@board[@player_play[1]] = @board[@player_play[0]]
		@board[@player_play[0]] = Node.new
		game_conditions
	end

	def change_player
		if @current_player == @player1
			@current_player = @player2
			show_board
			input_validation
		else
			@current_player = @player1
			show_board
			input_validation
		end
	end
end
		

class Node
	attr_accessor :name, :color
	attr_writer :view

	def initialize(view=" ", name=nil, color=nil)
		@view = view
		@name = name
		@color = color
	end


	def view
		@white_symbols = {
			"king"   => "\u265a", 
			"queen"  => "\u265b", 
			"rook"   => "\u265c", 
			"bishop" => "\u265d", 
			"knight" => "\u265e", 
			"pawn"   => "\u265f"
		}

		@black_symbols = {
			"king"   => "\u2654",
			"queen"  => "\u2655",
			"rook"   => "\u2656",
			"bishop" => "\u2657",
			"knight" => "\u2658",
			"pawn"   => "\u2659"
		}

		if self.color == nil
			return " "
		elsif self.color == "black"
			return @black_symbols[self.name]
		else
			return @white_symbols[self.name]
		end
	end
end

class Player
	attr_accessor :name, :color

	def initialize(name, color)
		@name = name
		@color = color
	end
end

player1 = Player.new("Player1", "white")
player2 = Player.new("Player2", "black")

game = Board.new(player1, player2)
game.board_making
game.board_setup
game.show_board
game.input_validation