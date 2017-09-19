time1 = Time.mktime(1989, 11, 20)
time2 = Time.mktime(2017, 9, 8)
time3 = time2 - time1
time4 = ((((time3/60)/60)/24)/365)

puts time4.to_i.to_s + ' años'