require 'open-uri'
require 'json'
class ApiAdapter
  def self.get_market_info movie_id
    url = "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=#{movie_id}"
    main_html = open(url){ |f| Nokogiri::HTML.parse JSON.parse(f.read)['main'] }
    items = main_html.css 'dl.ichiba_mainitem'
    items.map do |item|
      ichibaitem_watch = item.css('div[id^=ichibaitem_watch_]').first
      {
        shop_id: 1,
        product_id: ichibaitem_watch.attribute('id').to_s.sub('ichibaitem_watch_', ''),
        product_name: ichibaitem_watch.css('img').first.attribute('alt').to_s,
        product_image_url: ichibaitem_watch.css('img').first.attribute('src').to_s,
        maker: item.css('dd.maker').first.content,
        buy_num: get_num(item.css('span.buy').first),
        clicked_num: get_num(item.css('span.click').first),
        clicked_at_this_movie: get_num(item.css('dd.action span').reject{ |span| ['buy', 'click'].include? span.attribute('class').to_s }.first)
      }
    end
  end

  private
  def self.get_num span
    if span
      span.content.sub(',', '').sub('人', '').to_i
    else
      0
    end
  end
end