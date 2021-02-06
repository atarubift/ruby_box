require 'bundler/setup'
require 'nokogiri'
require 'open-uri'
require 'csv'

def setup_doc(url)
  charset = 'utf-8'
  html = open(url) { |f| f.read }
  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.search('br').each { |n| n.replace("\n") }
  doc
end

def scrape(url)
  doc = setup_doc(url)
  page_title = doc.xpath('div/h1').text
  detail_url = doc.xpath('div/h2/a').attribute('href').value

  [page_title, detail_url, url]
end

if __FILE__ == $0
  urls = [
    'https://www.example1.com',
    'https://www.example2.com',
    'https://www.example3.com'
  ]
  csv_header = ['ページタイトル', '詳細URL', 'URL']

  CSV.open('result.csv', 'w') do |csv|
    csv << csv_header
    urls.each do |url|
      begin
        csv << scrape(url)
      rescue
        # エラー処理
        #         # 例）　csv << ['err', 'err', url]
      end
    end
  end
end
