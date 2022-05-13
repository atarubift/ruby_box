# バブルソート

def bubbleSort(num)
  len = num.length                           # 数列の長さを格納
  len.times do |i|                           # 数列の長さ分ループ
    (len - 1).downto(i+1) do |j|             # 数列の長さ-1～i+1までループ
      if num[j]  < num[j-1]                  # 数列の一番奥とその一つ手前を比べる。
        num[j], num[j-1] = num[j-1], num[j]  # 奥の数の方が小さければ入れ替えを行う
      end
    end
    puts "#{i+1}回目；#{num.join(" ")}"       # 出力
  end
end

puts "数字を入力"
number = gets.split().map(&:to_i)             # 入力した数字をint型で配列に格納
bubbleSort(number)                            # 実行 
