puts 'Input a starting year:'
start_year = gets.chomp
puts 'Input an ending year:'
end_year = gets.chomp
puts ''

while start_year.to_i <= end_year.to_i

if start_year.to_f%400 == 0
puts start_year
elsif start_year.to_f%100 == 0
elsif start_year.to_f%4 == 0
puts start_year
end

start_year = start_year.to_i + 1

end