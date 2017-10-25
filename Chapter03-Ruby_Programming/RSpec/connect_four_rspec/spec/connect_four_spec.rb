require 'connect_four.rb'

describe Game do

	let(:player1) {Player.new("Player1", "R")}
	let(:player2) {Player.new("Player2", "Y")}
	let(:game) {Game.new(player1, player2)}


	describe "#create_board" do 

		context "when the game initialize" do 
			it "should call 'create_board'" do 
				expect(game).to receive(:create_board)
				game.create_board
			end

			it "creates a board with 42 spaces" do
				game.create_board 
				expect(Game.class_variable_get(:@@board).size).to eql(42)
			end

			it "creates the board as a Hash object" do 
				expect(Game.class_variable_get(:@@board)).to be_kind_of(Hash)
			end
		end
	end

	describe "#introduction" do

		context "when the game initialize" do 
			it "should call 'introduction'" do
				expect(game).to receive(:introduction)
				game.introduction
			end
		end
	end

	describe "#display_board" do 

		context "when the game initialize" do 
			it "should call 'display'" do 
				game.display_board
			end
		end

		context "when called" do 
			it "should return a string object" do 
				expect(game.display_board).to be_kind_of(String)
			end
		end
	end

	describe "#play" do 

		context "when the player choose a column" do 
			it "should call 'play" do
				input = double
				expect(player1).to receive(:play).with(input)
				player1.play(input)
			end
		end
	end 

	describe "#player_input" do 

		context "when the grid is displayed" do 
			it "should call 'player_input'" do 
				expect(game).to receive(:player_input)
				game.player_input
			end
		end
	end				
end