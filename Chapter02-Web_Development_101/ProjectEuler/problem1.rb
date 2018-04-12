number = 0
sum = 0

while number < 999
  number = number + 1
  
  if (number % 3 == 0 or number % 5 == 0)
    sum += number
  end
end

puts sum

