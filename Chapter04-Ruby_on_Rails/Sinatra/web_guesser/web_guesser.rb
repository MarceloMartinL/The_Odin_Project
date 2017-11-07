require 'sinatra'
require 'sinatra/reloader'

$number = rand(101)

def check_guess(guess_number)
	
	if guess_number > ($number+5)
		"Way too high!"
	elsif guess_number < ($number-5)
		"Way too low!"
	elsif guess_number > $number
		"Too high!"
	elsif guess_number < $number
		"Too low!"
	elsif guess_number == $number
		"You got it right!"
	end		
end

get '/' do
	guess = params['guess'].to_i
	message = check_guess(guess)
  erb :index, :locals => {:number => $number, :message => message}
end