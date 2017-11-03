require 'yaml'

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
		play_flow(@player_play)
	end


	def input_convertion(input)
		@letter_convertion = {"a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8}
		@opponent_piece = @board[input[1]].name
		@first_coord_convertion = input[0]
		@second_coord_convertion = input[1]
		@start_node = @board[input[0]]
		@final_node = @board[input[1]]
		@piece_name = @board[input[0]].name
		final_movement = []
		x1 = @letter_convertion[input[0][0]]
		y1 = input[0][1].to_i
		x2 = @letter_convertion[input[1][0]]
		y2 = input[1][1].to_i
		@start_coord = [x1,y1]
		@final_coord = [x2,y2]
		final_movement << (x2 - x1)
		final_movement << (y2 - y1)
		final_movement
	end

	def movement_validation(player_mov)
		correct_mov = []
		piece_movs = {
			"king"   => [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]],
			"knight" => [[-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1], [2,1], [1,2], [-1,2]],
			"rook"   => [[0,1], [1,0], [0,-1], [-1,0]],
			"bishop" => [[1,1], [1,-1], [-1,-1], [-1,1]],
			"queen"  => [[0,1], [1,1], [1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1]],
			"pawn"   =>	[[0,1], [0,-1], [1,1], [-1,1], [1,-1], [-1,-1], [0,2], [0,-2]]
		}
		
		if ["king", "knight"].include?(@piece_name)
			piece_movs[@piece_name].each do |mov|
				if mov == player_mov && (@final_node.color != @current_player.color || @final_node.color == nil)
					return true
				elsif (mov == player_mov && @check_on_curse == true) && (@final_node.color == @current_player.color && @final_node.name == "king") 
					return true				
				end
			end
		elsif ["rook", "bishop", "queen"].include?(@piece_name)
			piece_movs[@piece_name].each do |mov|
				(1..7).each do |num|
					iteration = [mov[0]*num, mov[1]*num]
					if iteration == player_mov
						#Stores the movement of the piece that allows it reach the endpoint.
						correct_mov = mov
						#If the way is clear then change the nodes.
						if cleared_way?(correct_mov) == true
							return true
						end
					end
				end
			end
		elsif @piece_name == "pawn"
			if piece_movs["pawn"][0].include?(player_mov) && (@final_node.color == nil && @start_node.color == "white")
				return true
			elsif piece_movs["pawn"][1].include?(player_mov) && (@final_node.color == nil && @start_node.color == "black")
				return true		
			elsif (piece_movs["pawn"][2..3].include?(player_mov) && @start_node.color == "white") && (@final_node.color != @current_player.color && @final_node.color != nil)
				return true	
			elsif (piece_movs["pawn"][4..5].include?(player_mov) && @start_node.color == "black") && (@final_node.color != @current_player.color && @final_node.color != nil)
				return true
			elsif (piece_movs["pawn"][6] == player_mov && @final_node.color == nil) && (@start_node.color == "white" && @first_coord_convertion[1] == "2")
				return true
			elsif (piece_movs["pawn"][7] == player_mov && @final_node.color == nil) && (@start_node.color == "black" && @first_coord_convertion[1] == "7")
				return true	
			end
		end
		return false
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
	
			if @board[@mov_translation].name != nil && @mov_translation != @second_coord_convertion
				return false
			elsif @board[@mov_translation].color != @current_player.color && @mov_translation == @second_coord_convertion
				return true
			elsif @board[@mov_translation].color == @current_player.color && (@board[@mov_translation].name == "king" && @check_on_curse == true)
				return true	
			end		
		end
	end

	#CHEQUEAR ANTES DE CAMBIAR DE TURNO
	def check_mate
		@check_mate_on = false
		all_pieces = []
		available_plays = []
		temp_board = YAML.dump(@board)
		@board.each do |key, piece|
			#DAR VUELTA ESTA WEA PARA QUE REVISE AL JUGAR CUANDO YA SE CAMBIO EL TURNO (a uno mismo)
			if piece.color == @current_player.color
				all_pieces << key
			elsif piece.color == nil || piece.color != @current_player.color
				available_plays << key		
			end
		end

		all_pieces.each do |piece|
			available_plays.each do |plays|
				@check_mate_on = true
				check_try = [piece, plays]
				check_validation = movement_validation(input_convertion(check_try))

				if check_validation == true
					@board[plays] = @board[piece]
					@board[piece] = Node.new
					puts "AKA #{piece} to #{plays}"
					puts "#{all_pieces.size} to #{available_plays.size}"
					show_board
					
					puts "SOY INVISIBLEEEE"
					check_condition
					puts "REGRESE DE REVISAR EL CHECK"
					if @current_player.in_check == false
						@check_mate_on = false
						@board = YAML.load(temp_board)
						puts "ACA TERMINA LA WEA PORQUE NO ESTA EN CHECK"
						return false
					end
					@board = YAML.load(temp_board)
				end
				puts "ACA HAY UN LOOP PQ EL WEON ESTA EN CHECKKKK!!!!"

			end
		end
		finish_game
	end

	def play_flow(play)
		if movement_validation(input_convertion(play)) == true
			node_change(play)
		else
			puts "\nError! Your piece cannot move there, try again!"
			input_validation
		end
	end

	def check_condition
		king_position = ""
		@check_on_curse = false
		enemy_position = []
		@board.each do |key, piece|
			if piece.name == "king" && piece.color == @current_player.color
				king_position = key
			elsif piece.color != @current_player.color && piece.color != nil
				enemy_position << key				
			end
		end

		p king_position
		p enemy_position
		enemy_position.each do |value|
			@check_on_curse = true
			check_try = [value,king_position]
			check_validation = movement_validation(input_convertion(check_try))
			puts "#{check_try} : #{check_validation} : #{@piece_name}"
			if check_validation == true
				@current_player.in_check = true
				puts "player in check!!!!"
				break
			else
				@current_player.in_check = false
			end
		end
		@check_on_curse = false
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
		if @eliminated_piece.name == "king"
			show_board
			finish_game
		end
	end

	def finish_game
		if @check_mate_on == true
			puts "CHECKMATE !!! #{@current_player.name} lose the game."
			exit
		else
			puts "\nThe King is DEAD !!!"
			puts "#{@current_player.name} WON THE GAME !!!"
			exit
		end
	end

	def check_state
		@board[@player_play[0]] = @final_node
		@board[@player_play[1]] = @start_node
		puts "\nYou are in CHECK"
		puts "You MUST do a movement to get out of CHECK"
		input_validation
	end

	def game_conditions
		check_condition
		if @current_player.in_check == true
			check_state
		elsif @piece_name == "pawn"
			win_condition 
			promotion_check
		else
			win_condition
			change_player
		end
	end

	def node_change(transition)
		@eliminated_piece = @board[@player_play[1]]
		@board[transition[1]] = @board[@player_play[0]]
		@board[transition[0]] = Node.new
		game_conditions
	end

	def change_player
		if @current_player == @player1
			@current_player = @player2
			show_board
			check_mate
			check_condition
			input_validation
		else
			@current_player = @player1
			show_board
			check_mate
			check_condition
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
	attr_accessor :name, :color, :in_check

	def initialize(name, color, in_check=false)
		@name = name
		@color = color
		@in_check = in_check
	end
end

player1 = Player.new("Player1", "white")
player2 = Player.new("Player2", "black")

game = Board.new(player1, player2)
game.board_making
game.board_setup
game.show_board
game.input_validation