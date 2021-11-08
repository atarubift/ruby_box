require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :user => 'ataruby', :password => '02010101_Shu', :database => 'test')
print "ID="
id = gets.to_i
print "name="
na = gets
query = %{update languages set name = '#{na}' where id = "#{id}"}
results = client.query(query)

query = %q{select * from languages}
results = client.query(query)
results.each do |row|
    puts "--------------------"
      row.each do |key, value|
            puts "#{key} => #{value}"
              end
end
