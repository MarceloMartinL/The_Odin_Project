require 'yaml'

class Board

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@current_player = @player1
		@opponent_player = @player2
		board_making
		board_setup
		introduction
	end

	def introduction
		puts "               WELCOME TO CHESS !!!"
		puts "This is a command-line chess created with unicode symbols."
		puts "To play this game you just have to declare your piece movements"
		puts "following a simple syntax like this: c2 to c4."
		puts "\nPlayer1 is White and Player2 is Black." 
		puts "You can also enter 'save' to save your current game"
		puts "or 'load' to load a previus gameplay, ENJOY!\n"
		show_board
		input_validation
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

	#Saves the current gameplay.
	def save_game
		saves = []
		saves << @board
		saves << @current_player
		save_yaml = YAML.dump(saves)

		File.open('saved_game.yaml', 'w') do |file|
			file.puts save_yaml
		end
		puts "Your game has been saved."
		puts "Closing the game..."
		exit
	end

	#Loads a previus gameplay.
	def load_game
		load_gameplay = YAML.load(File.read 'saved_game.yaml')
		@board = load_gameplay[0]
		@current_player = load_gameplay[1]
		show_board
		input_validation
	end

  # Sets each piece on his corresponding initial position on the board.
	def board_setup
		initial_position = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]
		special_position = [8,1]
		pawn_position = [7,2]
		initial_color = ["black","white"]
		i = 0
		x = 0
		#loops through ranks 8 and 1 setting each class piece in his corresponding position.
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
		#loos through ranks 7 and 2 setting the pawn's pieces in his corresponding position.
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

		puts "\n" + top_board

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
			puts "\n#{@current_player.name} (#{@current_player.color}) please enter your move like this: b1 to c3"
			input = gets.chomp.downcase
			@player_play = input.split(" to ")
			#if the player wants to save his current gameplay.
			if input == "save"
				save_game
			#if the player wants to load a previus game.
			elsif input == "load"
				load_game		
			#if the input dosen't follow the 8 character syntax, sends an error message explaining the correct syntax.
			elsif input.length != 8
				puts "\nIncorrect number of characters, please follow this syntax: b1 to c3 (with spaces)"
			#if the input doesn't include the word 'to' then sends a message explaining the syntax.
			elsif !input.include?("to")
				puts "\nIncorrect syntax, please follow this example: b1 to c3 (with spaces)"
			#if the player doesn't enter a letter between a-h for columns and a number between 1-8 for rows then print a error message.
			elsif (!("a".."h").include?(@player_play[0][0]) || !("1".."8").include?(@player_play[0][1])) || (!("a".."h").include?(@player_play[1][0]) || !("1".."8").include?(@player_play[1][1]))
				puts "\n¡Error!.The correct syntax for coordinates is Letter (a - h) + Number (1 - 8)"
				puts "For example b1, g2 or f5, please try again!"
			#if the player is trying to move an enemy piece or and empty square, then print a error message.
			elsif @current_player.color != @board[@player_play[0]].color
				puts "¡Error!.That is not your piece or is an empty square, try again!"
			#if the input follows the correct syntax and the piece is the same color as the current player, then validate the input.
			elsif (@player_play.size == 2 && @current_player.color == @board[@player_play[0]].color) && (@player_play[0].length == 2 && @player_play[1].length == 2)
				validation = true
			end
		end
		play_flow(@player_play)
	end

  #Transform the letter of each coordinate into a number.
	def input_convertion(input)
		@letter_convertion = {"a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8}
		#stores the name of the node occupying the start square.
		@opponent_piece = @board[input[1]].name
		#stores the name of the node occupying the final square.
		@piece_name = @board[input[0]].name
		#stores the coordinate of the start square.
		@first_coord_convertion = input[0]
		#stores the coordinate of the final square.
		@second_coord_convertion = input[1]
		#stores the node which is occupying the start square.
		@start_node = @board[input[0]]
		#stores the node which is occupying the final square.
		@final_node = @board[input[1]]
		final_movement = []
		x1 = @letter_convertion[input[0][0]]
		y1 = input[0][1].to_i
		x2 = @letter_convertion[input[1][0]]
		y2 = input[1][1].to_i
		#stores the coordinate of the start square after being transformed into numbers.
		@start_coord = [x1,y1]
		#stores the coordinate of the final square after being transformed into numbers.
		@final_coord = [x2,y2]
		final_movement << (x2 - x1)
		final_movement << (y2 - y1)
		#stores the subtraction of the two squares coordinates to get the final move required.
		final_movement
	end

	#Validates if the final movement is legit for any piece.
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
		
		#if the final move equals to one of the moves of the king or knight pieces.
		if ["king", "knight"].include?(@piece_name)
			#iterates through each basic move of the corresponding piece.
			piece_movs[@piece_name].each do |mov|
				#if the final node color is nil or different from the start node color.
				if mov == player_mov && (@final_node.color != @current_player.color || @final_node.color == nil)
					return true
				#if check analysis is in progress, the final node color equals to the current player color and the final node name is king.
				elsif (mov == player_mov && @check_on_curse == true) && (@final_node.color == @current_player.color && @final_node.name == "king") 
					return true				
				end
			end
		#if the final move equals to one of the moves of the rook, bishop or queen pieces.
		elsif ["rook", "bishop", "queen"].include?(@piece_name)
			#iterates through each basic move of the corresponding piece.
			piece_movs[@piece_name].each do |mov|
				#iterates through number 1 to 7 multiplying the basics pieces moves and saving it.
				(1..7).each do |num|
					iteration = [mov[0]*num, mov[1]*num]
					#if the final move equals to multiplication of a basic move by a certain number and the way to the destination square is clear.
					if iteration == player_mov && cleared_way?(mov) == true			
						return true		
					end
				end
			end
		#if start node name is a pawn piece.
		elsif @piece_name == "pawn"
			#one positive rank move from a white piece to a nil node.
			if piece_movs["pawn"][0].include?(player_mov) && (@final_node.color == nil && @start_node.color == "white")
				return true
			#one negative rank move from a black piece to a nil code.
			elsif piece_movs["pawn"][1].include?(player_mov) && (@final_node.color == nil && @start_node.color == "black")
				return true	
			#a positive diagonal move from a white piece to a node of the opponent color.	
			elsif (piece_movs["pawn"][2..3].include?(player_mov) && @start_node.color == "white") && (@final_node.color != @current_player.color && @final_node.color != nil)
				return true	
			#a negative diagonal move from a black piece to a node of the opponent color.
			elsif (piece_movs["pawn"][4..5].include?(player_mov) && @start_node.color == "black") && (@final_node.color != @current_player.color && @final_node.color != nil)
				return true
			#a double positive rank move from a white piece on rank 2 position to a nil color node.
			elsif (piece_movs["pawn"][6] == player_mov && @final_node.color == nil) && (@start_node.color == "white" && @first_coord_convertion[1] == "2")
				return true
			#a double negative rank move from a black piece on rank 7 position to a nil color node.
			elsif (piece_movs["pawn"][7] == player_mov && @final_node.color == nil) && (@start_node.color == "black" && @first_coord_convertion[1] == "7")
				return true	
			end
		end
		return false
	end

 # Checks if the way to the final square is clear.
	def cleared_way?(correct_mov)
		#loops while the start node coordinate is different from the final node coordinate.
		while @start_coord != @final_coord
			#sums the start node coordinate with the basic move of the corresponding piece.
			@start_coord = [@start_coord[0] + correct_mov[0], @start_coord[1] + correct_mov[1]]
			x_new = ""
			#transform the Y axis of the coordinate into a string.
			y_new = @start_coord[1].to_s
			#transform the X axis of the coordinate back into a letter.
			@letter_convertion.each do |key, value|
				if @start_coord[0] == value
					x_new = key
				end
			end

			#saves the new translation coordinate following the syntax letter+number.
			@mov_translation = x_new + y_new
	
			#returns false if the node in the new coordinate is not nil and if it is different from the final node coordinate.
			if @board[@mov_translation].name != nil && @mov_translation != @second_coord_convertion
				return false
			#if the destination node color is different from the current player color and the translation coordinate equals to the final node coordinate.
			elsif @board[@mov_translation].color != @current_player.color && @mov_translation == @second_coord_convertion
				return true
			#if the destination node color equals to the current player color, check analyzing is in progress and the node name of the translation coordinate equals to king.
			elsif @board[@mov_translation].color == @current_player.color && (@board[@mov_translation].name == "king" && @check_on_curse == true)
				return true	
			end		
		end
	end

	#checks if the current player is in checkmate.
	def check_mate
		#start with checkmate analysis status to be false (not in progress).
		@check_mate_on = false
		all_pieces = []
		available_plays = []
		#saves the current board on a temporary variable.
		temp_board = YAML.dump(@board)
		#go through each node in the board.
		@board.each do |key, piece|
			#saves all coordinates that are of the same color of current player.
			if piece.color == @current_player.color
				all_pieces << key
			#saves all coordinates that are nil or from a different color of the current player.
			elsif piece.color == nil || piece.color != @current_player.color
				available_plays << key		
			end
		end

		#go through each pieces of the current player.
		all_pieces.each do |piece|
			#go through each available square(node) for the piece of the current player.
			available_plays.each do |plays|
				#sets checkmate analysis status to be true
				@check_mate_on = true
				#saves the current random piece coordinate and the current random available square coordinate.
				check_try = [piece, plays]
				#checks if it is possible for that piece to reach that available square.
				check_validation = movement_validation(input_convertion(check_try))
				#if the validation is true
				if check_validation == true
					#moves the piece to the available square.
					@board[plays] = @board[piece]
					@board[piece] = Node.new
					#checks if after the change the player is still in check.
					check_condition
					#if the current player is not in check anymore.
					if @current_player.in_check == false
						#set check analysis status as false.
						@check_mate_on = false
						#load the original board setup and return false.
						@board = YAML.load(temp_board)
						return false
					end
					#if the move is not valid for that piece, load the original board and try another play.
					@board = YAML.load(temp_board)
				end
			end
		end
		#if not available play gets the current player out of check, then it is checkmate and the game is over.
		finish_game
	end

	#Controls the game flow based on the input recived by the player.
	def play_flow(play)
		if movement_validation(input_convertion(play)) == true
			node_change(play)
		else
			puts "\nError! Your piece cannot move there, try again!"
			input_validation
		end
	end

	#check if the current player king piece is in check condition.
	def check_condition
		king_position = ""
		#start the check analysis status as false
		@check_on_curse = false
		enemy_position = []
		#go through each square(node) on the board.
		@board.each do |key, piece|
			#when the node name equals to king and it is the same color of the current player color.
			if piece.name == "king" && piece.color == @current_player.color
				#saves the coordinate of the king on the king_position variable.
				king_position = key
			#if the node color is either different from color of the current player and different from nil.
			elsif piece.color != @current_player.color && piece.color != nil
				#saves the node coordinate on the enemy_position array.
				enemy_position << key				
			end
		end

		#iterate over each enemy piece.
		enemy_position.each do |value|
			#sets check analysis stats as true.
			@check_on_curse = true
			#saves a new move from the current enemy piece to the current player king position.
			check_try = [value,king_position]
			#checks if the movement is legit for the enemy piece.
			check_validation = movement_validation(input_convertion(check_try))
			#if the movement is legit for that piece.
			if check_validation == true
				#sets the player in check condition as true and break the loop.
				@current_player.in_check = true
				break
			#if the movement is not legit.
			else
				#sets the in check condition as false.
				@current_player.in_check = false
			end
		end
		#if not none move to capture the king was legit sets the check analysis status as false.
		@check_on_curse = false
	end

	#Promotes a pawn to the piece of the player election.
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

	#Checks if a promotion condition has been accomplished.
	def promotion_check
		if @player_play[1][1] == "8" && @current_player.color == "white"
			promotion_menu
		elsif @player_play[1][1] == "1" && @current_player.color == "black"
			promotion_menu
    end
	end

	#Final messages and finish the game.
	def finish_game
		if @check_mate_on == true
			puts "\n#{@current_player.name} (#{@current_player.color}) is in CHECKMATE !!!\n#{@opponent_player.name} (#{@opponent_player.color})WON the game !!!"
			exit
		end
	end

	#Undoes the last play and warning the player he is in check.
	def check_state
		@board[@player_play[0]] = @final_node
		@board[@player_play[1]] = @start_node
		puts "\nYou are still in CHECK!"
		puts "You MUST do a movement to get out of CHECK."
		input_validation
	end

	#Checks for several game conditions after a play has been made.
	def game_conditions
		check_condition
		if @current_player.in_check == true
			check_state
		elsif @piece_name == "pawn"
			promotion_check
		end
		change_player
		show_board
		check_condition
			if @current_player.in_check == true
				check_mate
				puts "\n#{@current_player.name} (#{@current_player.color}) you are in CHECK!"
			end
		input_validation
	end

	#Moves the piece from the start square to the final square.
	def node_change(transition)
		@board[transition[1]] = @board[@player_play[0]]
		@board[transition[0]] = Node.new
		game_conditions
	end

  #Changes the current player and the opponent player.
	def change_player
		if @current_player == @player1
			@current_player = @player2
			@opponent_player = @player1
		else
			@current_player = @player1
			@opponent_player = @player2
		end
	end
end
		
#Set up the information of each square on the board.
class Node
	attr_accessor :name, :color
	attr_writer :view

	def initialize(view=" ", name=nil, color=nil)
		@view = view
		@name = name
		@color = color
	end

  #Controls the unicode representation of each piece based on his name.
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

#Set up the player information for the game.
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
