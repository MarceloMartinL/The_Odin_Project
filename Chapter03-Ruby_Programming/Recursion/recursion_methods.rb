	roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
  }

roman_mapping2 = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}

# Calculate the factorial of a number.
def factorial(n)
  if n == 0
    1
  else
    n * factorial(n-1)
  end
end

# Returns TRUE if the string is a palindrome.
def palindrome(string)
	
	if string.length == 1 || string.length == 0
		return true
	elsif string[0] == string[-1]

		palindrome(string[1..-2])
	else
		return false
	end
end

# Recursive method for the folk song 99 bottles of beer.
def beers(n)
	if n == 0
		puts "no more bottles of beer on the wall"
	else
		puts "#{n} bottles of beer on the wall"
		beers(n-1)
	end
end

# Returns the number in the position N of the fibonacci sequence.
def fibonacci(n)
	if n == 0
		return 0
	elsif n == 1
		return 1
	else
		return (fibonacci(n-1)+fibonacci(n-2))
	end

end

# Recursive method that flattens an array, e.g. [[1,2],[3,4]]
def flatten(array, result = [])
  array.each do |element|
    if element.kind_of?(Array)
      flatten(element, result)
    else
      result << element
    end
  end 
  result
end

# Using the roman_mapping transform an integer to a roman numeral.
def integer_to_roman(roman_mapping, number, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return integer_to_roman(roman_mapping, modulus, result) if quotient > 0
  end
end

# Using the roman_maping2 transform a roman numeral to an integer.
def roman_to_integer(roman_mapping2, str, result = 0)
  return result if str.empty?
  roman_mapping2.keys.each do |roman|
    if str.start_with?(roman)
      result += roman_mapping2[roman]
      str = str.slice(roman.length, str.length)
      return roman_to_integer(roman_mapping2, str, result)
    end
  end
end