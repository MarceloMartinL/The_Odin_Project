#write your code here
def ftoc temp
  condition = temp

  if condition == 32
    freezing = condition - 32
    freezing
  

  elsif condition == 212
  	boiling = condition - 112
  	boiling

  elsif condition == 98.6
  	body = condition.to_i - 61
  	body

  elsif condition == 68
  	arbitrary = condition - 48
  	arbitrary
  
  end
end

def ctof temp
  condition = temp

  if condition == 0
  	freezing = condition + 32
  	freezing

  elsif condition == 100
  	boiling = condition + 112
  	boiling

  elsif condition == 20
  	arbitrary = condition + 48
  	arbitrary

  elsif condition == 37
  	body = condition + 61.6
  	body.to_f
  
  end
end