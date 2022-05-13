class Main
  def run
    mana = true
    con = 1
    while mana
      case con
      when 1
        con = input
      when 2
        puts "Good bye^^"
        break
      else
        puts "You are a twisted one!"
        break
      end
    end
  end

  def input
    con = 0
    alpha = ('A'..'J').to_a
    myUser = Array.new
    mana = true
    puts "What are you preferences?\nPlease tell us the following questions on a 4-point scale."
    puts "(1:Interesting 2:Normal 3:Boring 4:Not-seen)"

    10.times do |i|
      flag = true
      while flag
        print "movie#{alpha[i]}: "
        evalution = gets.to_i
        if evalution == 0 || evalution > 4
          puts "Please enter a range from 1 to 4. Try again."
        else
          myUser[i] = evalution
          flag = false
        end
      end
    end

    sam = create
    res = comparison(myUser, create)
    rec = recommend(myUser, create, res)
    recUni = rec.uniq.sort
    if recUni.length < 1
      puts "There are no recommended films."
    else
      puts "This movie is recommended for you: "
      recUni.each do |var|
        puts "- Movie#{alpha[var]}"
      end
    end

    while mana
      print "Continue?(1:Yes 2:No): "
      con = gets.to_i
      if con == 333
        debug(myUser, sam)
      else
        break
      end
    end
    con
  end

  def create
    sampleUser = Array.new
    50.times do 
      sampleEva = Array.new
      10.times do 
        sampleEva << rand(1..4)
      end
      sampleUser << sampleEva
    end
    sampleUser
  end

  def comparison(my, sample)
    total = Array.new
    ans = Array.new
    sv = 0
    50.times do |i|
      count = 0
      10.times do |j|
        count += 1 if my[j] == sample[i][j]
      end
      # puts "i= #{i}: count= #{count}:"
      total << count
      if sv < total.max
        sv = total.max
        ans.clear        
      end

      if sv < count || sv == count
        ans << i
      end
    end
    # print "#{total}\n"
    ans
  end

  def recommend(my, sample, result)
    movie = Array.new
    result.each do |var|
      10.times do |i|
        if my[i] == 4 && sample[var][i] == 1
          movie << i
        end
      end
    end
    movie
  end

  def debug(my, sample)
    puts "Welcom to Debug Mode"
    puts "-" * 50
    puts "Your result:"
    print "| You |"
    my.length.times do |i|
      if i < 9
        print " #{my[i]} |"
      else
        puts " #{my[i]} |"
      end
    end

    puts "-" * 50
    puts "Sample user:"
    50.times do |i|
      print "| User#{sprintf("%2d",i+1)} |"
      10.times do |j|
        if j < 9
          print " #{sample[i][j]} |"
        else
          puts " #{sample[i][j]} |"
        end
      end
    end
  end
end

main = Main.new
main.run
