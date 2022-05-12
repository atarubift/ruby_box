print "Enter the number: "
ans = Array.new(6, 0)
flag = true

while flag
  num = gets.to_i
  if num > 0
    num.times do
      saikoro = rand(1..6)
      it = saikoro - 1
      ans[it] += 1
    end
    
    6.times do |i|
      puts "|#{i+1}|#{ans[i]}|#{(ans[i]/num.to_f).floor(2)}|"
    end
    flag = false
  else
    puts "Enter an integer greater than or equal to 1."  
    print "Please enter again: "
  end
end 
