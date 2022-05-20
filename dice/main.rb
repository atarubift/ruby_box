def dice(count, saikoro)
  sum = 0
  count.times do
    sum += rand(1..saikoro)
  end
  sum
end

flag = true
while flag
  puts "Enter the Dice"
  a, b = gets.split('d')
  puts dice(a.to_i, b.to_i)
  print 'Continue?(1:Yes Other:No):'
  break if gets.to_i != 1
end


