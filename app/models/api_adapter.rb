require 'open-uri'
require 'json'
class ApiAdapter
  def self.get_market_info movie_id
    url = "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=#{movie_id}"
    main_html = open(url){ |f| Nokogiri::HTML.parse JSON.parse(f.read)['main'] }
    items = main_html.css 'div'
    items.select{ |item|
      item.attribute('id').to_s.start_with? 'ichibaitem_watch'
    }.map do |item|
      { shop_id: 1, product_id: item.attribute('id').to_s.sub('ichibaitem_watch_', '') }
    end
  end
end