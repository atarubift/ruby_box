i = 0

31.times do |i|

  if i % 15 == 0 && i != 0
    puts "FizzBuzz!"
  elsif i % 3 == 0 && i != 0
    puts "Fizz!"
  elsif i % 5 == 0 && i != 0
    puts "Buzz!"
  else
    puts i
  end
end


