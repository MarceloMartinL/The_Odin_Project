def fibonacci
  sec = 0
  fibo = [1, 2, 3, 5, 8]
  sum = 0

  while sec < 4000000
    track = fibo.count
    sec = fibo[track - 1] + fibo[track - 2]

      if sec < 4000000
      fibo.push sec
      end
  end

  fibo.each do |x|
  	if x%2 == 0
  		sum += x
    end
  end
  puts sum
end

puts fibonacci
