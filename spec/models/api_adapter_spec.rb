require 'rails_helper'
describe ApiAdapter do
  describe '.get_market_info' do
    let(:expected) do
      product_ids = %w[az4056000816 azB000P5FHCQ azB000CQCOLA azB00014B10S azB0044BIQDO azB009K2N4FW azB009K2QJ0E]
      product_names = [
        '陰陽道の本―日本史の闇を貫く秘儀・占術の系譜 (NEW SIGHT MOOK Books Esoterica 6)',
        '新豪血寺一族-煩悩解放-(DVD付)',
        '新・豪血寺一族-煩悩解放-',
        '新豪血寺一族 闘婚 NG 【NEOGEO】',
        'レッツゴー！陰陽師',
        '陰陽師　安倍　晴明風　  男性M    コスプレ衣装　 　完全オーダメイドも対応',
        '陰陽師  彰子風　  女性M    コスプレ衣装　 　完全オーダメイドも対応asterInPla'
      ]
      product_image_urls = %w[
        http://ecx.images-amazon.com/images/I/51H24893PSL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/31GhQQVVoEL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/31ZFo3xRGtL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/51Akr-jxa2L._AA178_.jpg
        http://ecx.images-amazon.com/images/I/61so4UfAVtL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/41RGc7k2rUL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/41DecVejRuL._AA178_.jpg
      ]
      product_ids.each_with_index.map{ |product_id, i| { shop_id: 1, product_id: product_id, product_name: product_names[i], product_image_url: product_image_urls[i] } }
    end

    before do
      stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
    end

    it '与えられた動画IDに対して、その市場に登録されている商品の店舗IDと商品情報のhashの配列が帰ってくる' do
      expect(ApiAdapter.get_market_info 'sm9').to eq expected
    end
  end
end