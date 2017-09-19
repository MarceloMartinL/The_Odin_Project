#write your code here
def ftoc farenheit
  temp = (farenheit - 32) * 5/9
end

def ctof celsius
  temp = (celsius.to_f * 9/5) + 32
  temp.to_f
  
end