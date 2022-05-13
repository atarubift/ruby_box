# 線形探索

def linerSearch(data, target)
  bool = -1
  count = 0
  while count <= data.length 
    if data[count] == target
      bool = count
      break
    end
    count += 1
  end
  bool
end

print "格納する値："
data = gets.split().map(&:to_i)
print "探す値："
target = gets.to_i
search = linerSearch(data, target)

if search >= 0
  puts "#{target}は#{search+1}番目に見つかりました。"
else
  puts "#{target}は見つかりませんでした。"
end
