# ユークリッドの互除法

def euqlid(a, b)
  while b > 0
    mod = a % b
    a = b
    b = mod
  end
  a
end

print "aの値:"
a = gets.to_i
print "bの値:"
b = gets.to_i

puts "aとbの最小公約数は#{euqlid(a,b)}です"
