require 'yaml'

class Hangman
	attr_accessor :message, :tablet, :message, :secret_word_arr

	def initialize(turn=9,tablet=[],incorrect_letters=[],secret_word=nil, secret_word_arr=nil)
		@turn = turn
		@tablet = tablet
		@incorrect_letters = incorrect_letters
		@secret_word = secret_word
		@secret_word_arr = secret_word_arr
		@save_arr = [@turn, @tablet, @incorrect_letters, @secret_word, @secret_word_arr]
		@message = ""
		start
	end

	def start
		dictionary = File.readlines('5desk.txt')
		@secret_word = ""

			# Loop until secret_word gets assigned a word between 5 and 12 characters length.
		until @secret_word.size >= 5 && @secret_word.size < 13
			@secret_word = dictionary[rand(61407)].strip.upcase
		end

		@secret_word_arr = @secret_word.scan(/./)

		@secret_word.size.times do 
			@tablet << "-"	
		end
	end

	def play(input)
		if !@secret_word_arr.include?(input)
			if @incorrect_letters.include?(input)
				@message = "You already try #{input} and it was wrong!!! I discount you 1 turn for being retarded."
				@turn -= 1
			else
				@incorrect_letters << input
				@turn -= 1
			end
		else
			@secret_word_arr.each_with_index do |letter, index|
				if letter == input
					@tablet[index] = letter
				end
			end
		end
		game_over
	end

	def game_over
		if @tablet.include?("-") == false
			@message = "Game Finish!\nThe YOU WON THE GAME!!!"
			
		elsif @turn < 1
			@message = "Game Finish!\nThe hanged man DIES!!!"
		end
	end

	def display
		@tablet.join(" ")
	end

	def status
		@status = "Incorrect: #{@incorrect_letters}  Turns left: #{@turn}"
	end

	def incorrect_letters
		@incorrect_letters
	end

  def to_yaml
		YAML.dump ({
			:turn => @turn,
			:tablet => @tablet,
			:incorrect_letters => @incorrect_letters,
			:secret_word => @secret_word,
			:secret_word_arr => @secret_word_arr
			})
  end

	def save_game
		save_file = self.to_yaml
		puts "Please enter a name for your save"
		input_save = gets.chomp.downcase
		
		File.open(input_save, "w") do |file| 
			file.puts save_file 
		end
		puts "Your game has been saved as: #{input_save}"
		puts
		display
	end

	# Verify if saved file exist, if exist then load it else ask again.
	def self.load_game
		puts "Please enter the name of your saved game"
		input_load = gets.chomp.downcase
		puts
		data = YAML.load(File.read(input_load))
		load_game = self.new(data[:turn], data[:tablet], data[:incorrect_letters], data[:secret_word], data[:secret_word_arr])
		load_game.display
	end	
end