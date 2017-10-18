# Iteration method that returns N members of the fabonacci sequence.
def fib(n)
	arr = [0,1]
	if n == 1
		return arr[0]
	elsif n == 2
		return arr
	else
		(n-2).times do 
		arr << arr[-1] + arr[-2]
		end
	end
	arr
end

# Recursive methot that returns N members of the fabonacci sequence.
def fibs_rec(n)
	arr = [0,1]
	if n == 1
		return arr[0]
	elsif n == 2
		return arr
	else
		arr = fibs_rec(n-1)
		arr << arr[-1] + arr[-2]
	end

end

puts fibs_rec(4)
