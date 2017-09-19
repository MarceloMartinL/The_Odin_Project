bottles = 99
while bottles != 0
puts bottles.to_s + ' bottles of beer on the wall'
puts bottles.to_s + ' bottles of beer'
bottles = bottles - 1
puts 'take one down, pass it around'

if bottles == 1
puts bottles.to_s + ' bottle of beer on the wall'
else 
puts bottles.to_s + ' bottles of beer on the wall'
end

puts ''

if bottles == 1
puts bottles.to_s + ' bottle of beer on the wall'
puts bottles.to_s + ' bottle of beer'
bottles = bottles - 1
puts 'take one down, pass it around'
puts bottles.to_s + ' bottles of beer on the wall'
end 

end