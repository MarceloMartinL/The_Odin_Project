all = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
number = 0
number2 = 1
void = []
primes = []  
total = all.count
start = all[number]
finish = all[total]

  while start != finish
    while number2 != start
      if start%number2 == 0
        void.push number2
        track = void.count
        if start == number2 and track == 2
          primes.push start
        end
      end
    number2 += 1
    end
    start[number + 1]
  end
    
  puts primes