def caesar (string, number)
  sentence = string
  cipher = ""
  sentence.scan(/./) do |letter|
  	if letter =~ /[a-z]/
      convertion = letter.ord + number
      if convertion >= 97 and convertion <= 122 
        cipher += convertion.chr
      elsif convertion > 122
      	convertion = 96 + (convertion - 122)
      	cipher += convertion.chr
      elsif convertion < 97
      	convertion = 123 - (97 - convertion)
      	cipher += convertion.chr
      end

    elsif letter =~ /[A-Z]/
      convertion = letter.ord + number
      if convertion >= 65 and convertion <= 90
      	cipher += convertion.chr
      elsif convertion > 90
      	convertion = 64 + (convertion - 90)
      	cipher += convertion.chr
      elsif convertion < 65
      	convertion = 91 - (65 - convertion)
      	cipher += convertion.chr
      end

    elsif letter == " "
      cipher += " "
      
    else
      cipher += letter
    end
  end
 cipher
end

puts caesar("", 3)

