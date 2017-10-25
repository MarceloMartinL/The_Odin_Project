class Game
	attr_accessor :board

	def initialize(p1, p2)
		@@player1 = p1
		@@player2 = p2
		introduction
		create_board
		start_player
	end

	def introduction
		puts "  \n                   ¡Welcome to Connect Four!\n"
		puts "     This is a 2-players game where each player have a different"
		puts "     colored disc, Player 1 is (R)ed and Player 2 is (Y)ellow.\n"
		puts "Rules:"
		puts "   - Players takes turns to choose a column and drop his discs from the top."
		puts "   - The empty spaces are represented as 'O' whereas the discs are 'R' and 'Y'."
		puts "   - The discs occupy the next available space within the column."
		puts "   - The first player who forms a horizontal, vertical or diagonal"
		puts "     line of four of one's own discs wins the game."
	end

	def create_board
		puts
		@@board = {}
		i = 1
		while i < 43
			@@board[i] = "O"
			i += 1
		end
		display_board
	end

	def win_condition?
		@win_condition = [
			[@@board[1],  @@board[2],  @@board[3],  @@board[4]],  [@@board[2],  @@board[3],  @@board[4],  @@board[5]], 
			[@@board[3],  @@board[4],  @@board[5],  @@board[6]],  [@@board[4],  @@board[5],  @@board[6],  @@board[7]],
			[@@board[8],  @@board[9],  @@board[10], @@board[11]], [@@board[9],  @@board[10], @@board[11], @@board[12]],
			[@@board[10], @@board[11], @@board[12], @@board[13]], [@@board[11], @@board[12], @@board[13], @@board[14]],
			[@@board[15], @@board[16], @@board[17], @@board[18]], [@@board[16], @@board[17], @@board[18], @@board[19]],
			[@@board[17], @@board[18], @@board[19], @@board[20]], [@@board[18], @@board[19], @@board[20], @@board[21]],
			[@@board[22], @@board[23], @@board[24], @@board[25]], [@@board[23], @@board[24], @@board[25], @@board[26]],
			[@@board[24], @@board[25], @@board[26], @@board[27]], [@@board[25], @@board[26], @@board[27], @@board[28]],
			[@@board[29], @@board[30], @@board[31], @@board[32]], [@@board[30], @@board[31], @@board[32], @@board[33]],
			[@@board[31], @@board[32], @@board[33], @@board[34]], [@@board[32], @@board[33], @@board[34], @@board[35]],
			[@@board[36], @@board[37], @@board[38], @@board[39]], [@@board[37], @@board[38], @@board[39], @@board[40]],
			[@@board[38], @@board[39], @@board[40], @@board[41]], [@@board[39], @@board[40], @@board[41], @@board[42]],
			[@@board[1],  @@board[8],  @@board[15], @@board[22]], [@@board[8],  @@board[15], @@board[22], @@board[29]],
			[@@board[15], @@board[22], @@board[29], @@board[36]], [@@board[2],  @@board[9],  @@board[16], @@board[23]],
			[@@board[9],  @@board[16], @@board[23], @@board[30]], [@@board[16], @@board[23], @@board[30], @@board[37]],
			[@@board[3],  @@board[10], @@board[17], @@board[24]], [@@board[10], @@board[17], @@board[24], @@board[31]],
			[@@board[17], @@board[24], @@board[31], @@board[38]], [@@board[4],  @@board[11], @@board[18], @@board[25]],
			[@@board[11], @@board[18], @@board[25], @@board[32]], [@@board[18], @@board[25], @@board[32], @@board[39]],
			[@@board[5],  @@board[12], @@board[19], @@board[26]], [@@board[12], @@board[19], @@board[26], @@board[33]],
			[@@board[19], @@board[26], @@board[33], @@board[40]], [@@board[6],  @@board[13], @@board[20], @@board[27]],
			[@@board[13], @@board[20], @@board[27], @@board[34]], [@@board[20], @@board[27], @@board[34], @@board[41]],
			[@@board[7],  @@board[14], @@board[21], @@board[28]], [@@board[14], @@board[21], @@board[28], @@board[35]],
			[@@board[21], @@board[28], @@board[35], @@board[42]], [@@board[4],  @@board[12], @@board[20], @@board[28]],
			[@@board[3],  @@board[11], @@board[19], @@board[27]], [@@board[11], @@board[19], @@board[27], @@board[35]],
			[@@board[2],  @@board[10], @@board[18], @@board[26]], [@@board[10], @@board[18], @@board[26], @@board[34]],
			[@@board[18], @@board[26], @@board[34], @@board[42]], [@@board[1],  @@board[9],  @@board[17], @@board[25]],
			[@@board[9],  @@board[17], @@board[25], @@board[33]], [@@board[17], @@board[25], @@board[33], @@board[41]],
			[@@board[8],  @@board[16], @@board[24], @@board[32]], [@@board[16], @@board[24], @@board[32], @@board[40]],
			[@@board[15], @@board[23], @@board[31], @@board[39]], [@@board[4],  @@board[10], @@board[16], @@board[22]],
			[@@board[5],  @@board[11], @@board[17], @@board[23]], [@@board[11], @@board[17], @@board[23], @@board[29]],
			[@@board[6],  @@board[12], @@board[18], @@board[24]], [@@board[12], @@board[18], @@board[24], @@board[30]],
			[@@board[18], @@board[24], @@board[30], @@board[36]], [@@board[7],  @@board[13], @@board[19], @@board[25]],
			[@@board[13], @@board[19], @@board[25], @@board[31]], [@@board[19], @@board[25], @@board[31], @@board[37]],
			[@@board[14], @@board[20], @@board[26], @@board[32]], [@@board[20], @@board[26], @@board[32], @@board[38]],
			[@@board[21], @@board[27], @@board[33], @@board[39]]
		]

		@win_condition.each do |item|
			if item.uniq.size == 1 && !item.include?("O")
				return true
			else
				next
			end
		end
	end

	def game_over
		if win_condition? == true
			puts "The game finish! #{self.name} WON the game!!!"
			exit
		elsif draw_condition? == true
			puts "Drawww !!! The game finish without a winner!!!"
			exit
		end			
	end

	def draw_condition?
		return true if @@board.all? {|key, value| value != "O"}
	end

	def change_player
		if self.name == "Player1"
			@@player2.player_input
		else
			@@player1.player_input
		end
	end

	def start_player
		random = rand(1..2)
			if random == 1
				@@player1.player_input
			else
				@@player2.player_input
			end
	end

	def player_input
	
		input_validation = false
		while input_validation == false
			puts "\n#{self.name} choose a column to drop your mark (1 - 7)"
			input = gets.chomp

			if input.scan(/[a-z]/).size > 0 || input.scan(/[A-Z]/).size > 0
				puts "No letters allowed, only numbers!\n"
			elsif input.length != 1
				puts "Please choose only one column (one number)\n"
			elsif @@board[input.to_i] != "O"
				puts "This column is full, please choose another.\n"
			elsif input.to_i > 7
				puts "The number must be between 1 - 7, TRY AGAIN!\n"
			else
				input_validation = true
			end
		end
		play(input)
	end

	def play(input)
		
			case input
			when "1"
				[36,29,22,15,8,1].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "2"
				[37,30,23,16,9,2].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "3"
				[38,31,24,17,10,3].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "4"
				[39,32,25,18,11,4].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "5"
				[40,33,26,19,12,5].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "6"
				[41,34,27,20,13,6].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end
			when "7"	
				[42,35,28,21,14,7].each do |num|
					if @@board[num] == "O"
						@@board[num] = self.color
						break
					end
				end		
			end
		display_board
		game_over
		change_player	
	end

	def display_board
		grid = ""
		i = 1
		6.times do
			7.times do 
				grid += "#{@@board[i]} "
				i += 1
			end
			grid += "\n"
		end
		puts grid
		puts "-------------"
		puts "1 2 3 4 5 6 7"
		grid
	end
end
 
class Player < Game 
	attr_reader :color, :name
	def initialize(name, color)
		@name = name
		@color = color.upcase
	end
end

player1 = Player.new("Player1", "r")
player2 = Player.new("Player2", "y")
game = Game.new(player1, player2)
