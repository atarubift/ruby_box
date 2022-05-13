# バブルソート
def bubbleSort(num)
  len = num.length
  len.times do |i|
    (len - 1).downto(i+1) do |j|
      if num[j]  < num[j-1] 
        num[j], num[j-1] = num[j-1], num[j] 
      end
    end
    # puts "#{i+1}回目；#{num.join(" ")}"
  end
  num
end

# 二分探索
def binarySearch(num, pat)
  start = 0
  len = num.length - 1
  half = (start + len) / 2
  mid = num[half]
  count = 1

  while mid != pat
    puts "half=#{half}"
    if half < 0 || half > num.length 
      half = -1
      break
    elsif pat == mid
      break
    elsif pat < mid
      len = half - 1
    else
      start = half + 1
    end
    half = (start + len) / 2
    mid = num[half]
  end
  half
end

print "格納する数字:"
num = gets.split().map(&:to_i)
print "探す数字："
tar = gets.to_i
sort = bubbleSort(num)
binary = binarySearch(sort, tar)

if binary >= 0
  puts "#{binary+1}番目に見つかりました。"
else
  puts "数字はありません"
end

