require_relative 'hangman.rb'
require 'sinatra'
require 'sinatra/reloader' if development?

enable :sessions

get "/" do
 	session[:game] = Hangman.new if session[:game].nil?
 	@game = session[:game]
	letter = session.delete(:letter).to_s.upcase
	@game.play(letter) if !letter.empty?
	#@game.game_over


	erb :index, :locals => { :game_display => @game.display,
	                         :status => @game.status,
	                         :incorrect_letters => @game.incorrect_letters,
	                         :tablet => @game.tablet,
	                         :message => @game.message,
	                         :secret_word_arr => @game.secret_word_arr
	                          }
end

post "/" do 
	session[:letter] = params['letter']
	redirect "/"
end

post "/restart" do
	session[:game] = Hangman.new
	redirect "/"
end
