require 'open-uri'
require 'nokogiri'
require 'csv'

url = 'https://qiita.com/search?page=1&q=ruby&sort=like'
res = open(url)

body = res.read
charset = res.charset
html = Nokogiri::HTML.parse(body, url = nil, encoding = charset)

html.css('h1.searchResult_itemTitle').text

results = []
html.search('.searchResult_main').each do |node|
  title = node.css('.searchResult_itemTitle').inner_text
  tags = node.css('.tagList_item').map{ |article_tag| article_tag.inner_text }
  detail = node.css('.searchResult_snippet').inner_text
  results << { title: title, tags: tags, details: detail }
end

results.each.with_index(1) do |res, i|
  puts "#{i}番目の検索結果"
  puts "Title: #{res[:title]}"
  puts "Tags: #{res[:tags]}"
  puts "Details: #{res[:detail]}"
  puts '-----------------------------------------'
end

search_words = ['ruby', 'php', 'python', 'perl']
results = {}
search_words.each do |word|
  results[word] = []
  (1..100).each do |i|
    puts "================== #{word} #{i} =================="
    url = "https://qiita.com/search?page=#{i}&q=#{word}&sort=like"
    res = open(url)
    charset = res.charset
    body = res.read

    html = Nokogiri::HTML.parse(body, url = nil, encoding = charset)
    html.search('.searchResult').each do |node|
      title = node.css('.searchResult_itemTitle').text
      tags = node.css('.tagList_item').map{ |tag| tag.text }
      detail = node.css('.searchResult_snippet').text
      link = "https://qiita.com/" + node.css('.searchResult_itemTitle').css('a')[0][:href]
      stars = node.css('.list-unstyled.list-inline.searchResult_statusList li')[0].children.last.text.gsub(" ","")
      comments = node.css('.list-unstyled.list-inline.searchResult_statusList li')[1]&.text&.gsub(" ","")
      author = node.css('.searchResult_header').css('a')&.text
      results[word] << { stars: stars, title: title, tags: tags, detail: detail, link: link, comments: comments, author: author }
    end
  end
end

header = ['LGTM数', '記事タイトル', 'タグ', '見出し', 'URL', 'コメント数', '著者']

ruby_articles = results["ruby"].map{|res| [ res[:stars], res[:title], res[:tags], res[:detail], res[:link], res[:comments], res[:author] ] }
CSV.open('qiita_ruby.csv', 'w') do |csv|
  csv << header
  ruby_articles.each do |r|
    csv << r
  end
end

php_articles = results["php"].map{|res| [ res[:stars], res[:title], res[:tags], res[:detail], res[:link], res[:comments], res[:author] ] }
CSV.open('qiita_php.csv', 'w') do |csv|
  csv << header
  php_articles.each do |r|
    csv << r
  end
end

python_articles = results["python"].map{|res| [ res[:stars], res[:title], res[:tags], res[:detail], res[:link], res[:comments], res[:author] ] }
CSV.open('qiita_python.csv', 'w') do |csv|
  csv << header
  python_articles.each do |r|
    csv << r
  end
end

perl_articles = results["perl"].map{|res| [ res[:stars], res[:title], res[:tags], res[:detail], res[:link], res[:comments], res[:author] ] }
CSV.open('qiita_perl.csv', 'w') do |csv|
  csv << header
  perl_articles.each do |r|
    csv << r
  end
end
