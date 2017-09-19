puts 'Hey! Hello there. What\'s your name?'
name = gets.chomp
puts 'Nice to meet you ' + name + '!. Can you tell me your favorite number?'
number = gets.chomp
number2 = number.to_i + 1
puts 'I see. Hm.... I personally think that ' + number2.to_s + ' is a better number! Muahahahah.'