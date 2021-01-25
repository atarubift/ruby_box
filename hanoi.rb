# ハノイの塔

def hanoi(n, from, to, via)
  if n == 1
    puts "#{from} から #{to} へ移す"
  else
    hanoi(n - 1, from, via, to)
    puts "#{from} から #{to} へ移す"
    hanoi(n - 1, via, to, from)
  end
end

n = gets.to_i
hanoi(n, :A, :B, :C)
