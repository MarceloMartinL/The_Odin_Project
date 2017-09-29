def stock_picker (price_array)
  price_list = price_array
  best_trade = []
  max = price_list.max
  min = price_list.min
  max_index = price_list.index(max)
  min_index = price_list.index(min)

    if max_index > min_index
  	  best_trade.push(min_index)
  	  best_trade.push(max_index)

  	

    else
      while min_index > max_index

  	    price_list.delete_at(min_index)
        max_a = price_list(max_index)
        min_a = price_list(min_index)
        dif_a = max_a - min_a
        puts dif_a
  	  end
    end
  puts best_trade
end
stock_picker([3,5,6,1,5])
