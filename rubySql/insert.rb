require 'mysql2'

client = Mysql2::Client.new(:username => 'ataruby', :host => 'localhost',  :password => '02010101_Shu', :database => 'test')
print "ID:"
id = gets.to_i
print "language:"
lan = gets
query = %{insert into languages values (#{id}, "#{lan}")}
results = client.query(query)

query = %q{select * from languages}
results = client.query(query)
results.each do |row|
  puts "--------------------"
  row.each do |key, value|
    puts "#{key} => #{value}"
  end
end
