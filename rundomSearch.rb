
def rundomserch(count)
  go = []
  x = []
  count.times do |i|
    x[i] = rand(0.1..10.0)
    lo = Math.log(x[i])
    go[i] = x[i] ** 2 * lo - 2 * x[i] ** 2
  end
  ans = go.min
  puts "#{count}回の時"
  puts "x=#{x[go.index(ans)]}"
  puts "最小値：#{ans}"
end

i = 1 
while i <= 100000000
  rundomserch(i)
  i *= 10
end
