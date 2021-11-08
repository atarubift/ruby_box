require 'mysql2'
require 'prime'
require 'benchmark'

CLIENT = Mysql2::Client.new(:username => 'ataruby', :password => '02010101_Shu', :host => 'localhost', :database => 'math')

class Integer
  def divisor
    divisors = [1]
    primes = []
    Prime.prime_division(self).each do |prime|
      prime[1].times {primes << prime[0]}
    end

    1.upto(primes.size) do |i|
      primes.combination(i) do |prime|
        divisors << prime.inject{|a,b| a *= b}
      end
    end

    divisors.uniq!
    # divisors.sort!
    return divisors[rand(divisors.length)]
  rescue ZeroDivisionError
    return
  end
end

class Main
  def start
    seconds = Benchmark.realtime do
      @score = 0
      i = 1
      j = 0
      query = %q{select * from proans}
      results = CLIENT.query(query)
      results.each do |row|
        row.each do |key, value|
          if j == 0
            print "問#{i}: #{value} = "
            i += 1
            j = 1
          else
            ans = gets.to_i
            if ans == value
              puts "Correct!!"
              @score += 1
            else
              puts "Incorrect..."
            end
            j = 0
          end
        end
      end
      puts "成績; #{@score}点/20"
    end
    query = %{insert into result values ('#{@score}','#{seconds.round(2)}')}
    result = CLIENT.query(query)
    puts "所要時間:#{seconds.round(2)}"
  end


  def insert
    20.times do
      lot = rand(4)
    case lot
    when 0
      a = rand(10)
      b = rand(10)
      key = "#{a} + #{b}"
      val = a + b
    when 1
      a = rand(20)
      b = rand(0..a)
      key = "#{a} - #{b}"
      val = a - b
    when 2
      a = rand(10)
      b = rand(10)
      key = "#{a} × #{b}"
      val = a * b
    when 3
      a = rand(1..81).to_i
      b = a.divisor
      key = "#{a} ÷ #{b}"
      val = a / b
    end
      query = %{insert into proans values ('#{key}', #{val})}
      results = CLIENT.query(query)
    end
  end

  def dellist
    query = %{truncate table result}
    results = CLIENT.query(query)
  end

  def delpro
    query = %{truncate table proans}
    results = CLIENT.query(query)
  end

  def list 
    i = 0
    query = %q{select * from result}
    results = CLIENT.query(query)
    results.each do |row|
      puts "---------------"
      row.each do |key, value|
        if i == 0
          puts "#{key}: #{value}点"
          i = 1
        else
          puts "所要時間: #{value}s"
          i = 0
        end
      end
    end
  end

  def run
    ope = 0
    loop {
    case ope
    when 0
      delpro
      puts "|1 -> 開始|2 -> 過去のスコア|3 -> 記録を削除|4 -> 終了|"
      ope = gets.to_i
    when 1
      puts "start"
      insert
      start
      delpro
      ope = 0
    when 2
      puts "list"
      list
      ope = 0
    when 3
      puts "delete"
      dellist
      ope = 0
    else
      break
    end
    }
  end
end

main = Main.new
main.run
