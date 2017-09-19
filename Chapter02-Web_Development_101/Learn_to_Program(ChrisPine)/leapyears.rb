puts 'Please enter a starting year'
years = gets.chomp
puts 'Please now enter an ending year'
yeare = gets.chomp

yearone = years.to_i
yeartwo = yeare.to_i

while yearone <= yeartwo

  if yearone.to_f%400 == 0
    puts 'Leap year: ' + yearone.to_s
    yearone += 1
  end

  if yearone.to_f%4 == 0 and yearone.to_f%100 != 0
  	puts 'Leap year: ' + yearone.to_s
    yearone += 1

  else yearone += 1

  end
 end