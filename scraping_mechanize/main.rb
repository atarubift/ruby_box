require 'mechanize'

agent= Mechanize.new 
page = agent.get("http://www.hakodate-sweets.com/jomon-sweets.php") 
elements = page.search('a img')

elements.each do |ele| 
      puts ele.get_attribute('src') 
end 
