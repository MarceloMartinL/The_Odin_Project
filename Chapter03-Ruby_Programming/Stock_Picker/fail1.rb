def stock_picker (price_array)
  price_list = price_array
  max_times = price_array.size
  evaluation = []
  best_trade = []
  i = 0
  f = 1

  while f < max_times
    dif = price_list[i] - price_list[f]
    evaluation.push(dif)
    i += 1
    f += 1
  end

  max_difference = evaluation.index(evaluation.min)
  best_min = price_list.index(max_difference)
  best_max = price_list.index(max_difference + 1)
  best_trade.push(best_min)
  best_trade.push(best_max)

  puts best_trade
end
stock_picker([2,3,5,6,1])
