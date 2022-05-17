class Main
  def run
    flag = true
    control = 1
    while flag
      case control
      when 1
        control = reco
      when 2
        puts "Good bye:)"
        break
      when 3
        puts "You are a twisted one!:("
        break
      end
    end
  end

  def reco
    con = 0
    alpha = ('A'..'J').to_a
    myUser = question
    sample = shop
    comp, rat = compair(myUser, sample)
    flag = true
    if comp.empty?
      puts "You have no recommendations for you."
    else
      puts "This shop is recommended for you:"
      comp.each do |var|
        puts "|shop#{alpha[var]}|#{rat[var]*100}%|"
      end
    end

    while flag
      print "Continue?(1:Yes 2:No): "
      con = gets.to_i
      if con == 333
        debug(myUser, sample, rat)
      else
        break
      end
    end
    con
  end

  def question
    question = {
      "Which animal meat do you prefer?" => "1:Cow 2:Pig",
      "Which sauce do you prefer?" => "1:Demi-glace 2:Japanese-style 3:Ketchup",
      "How much do you like it grilled?" => "1:Rare 2:Medium-rare 3:Medium 4:Well-done",
      "Do you want any garnish?" => "1:Yes 2:No"
    }

    answer = Array.new

    question.each do |key, value|
      puts key
      puts value
      print "Answer:"
      answer << gets.to_i
    end
    answer
  end

  def shop
    shopSample = Array.new
    10.times do
      shopEva = Array.new
      shopEva << rand(1..2)
      shopEva << rand(1..3)
      shopEva << rand(1..4)
      shopEva << rand(1..2)
      shopSample << shopEva
    end
    shopSample
  end

  def compair(my, shop)
    total = Array.new
    ratio = Array.new
    ans = Array.new
    sv = 0

    10.times do |i|
      count = 0
      4.times do |j|
        count += 1 if my[j] == shop[i][j]
      end

      total << count if count != 0
      ratio << count / 4.0
      if total.empty? == false
        if sv < total.max
          sv = total.max
          ans.clear
        end

        if sv < count || sv == count
          ans << i
        end
      end
    end
    print "total=#{total}\n"
    return ans, ratio
  end

  def debug(my, shop, ratio)
    alpha = ('A'..'J').to_a
    puts "Welcom to Debug Mode"
    puts "-" * 50
    puts "Result:"
    print "| You |"
    my.length.times do |i|
      if i < 3
        print " #{my[i]} |"
      else
        puts " #{my[i]} |"
      end
    end

    10.times do |i|
      print "|Shop#{alpha[i]}|"
      4.times do |j|
        print " #{shop[i][j]} |"
      end
      puts "#{ratio[i]*100} |"
    end
  end
  puts "-" * 50
end

main = Main.new
main.run