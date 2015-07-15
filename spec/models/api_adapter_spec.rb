require 'rails_helper'
describe ApiAdapter do
  describe '.get_market_info' do
    let(:shop_ids){ Array.new(7, 1) }
    let(:product_ids){ %w[az4056000816 azB000P5FHCQ azB000CQCOLA azB00014B10S azB0044BIQDO azB009K2N4FW azB009K2QJ0E] }
    let(:product_names) do
      [
        '陰陽道の本―日本史の闇を貫く秘儀・占術の系譜 (NEW SIGHT MOOK Books Esoterica 6)',
        '新豪血寺一族-煩悩解放-(DVD付)',
        '新・豪血寺一族-煩悩解放-',
        '新豪血寺一族 闘婚 NG 【NEOGEO】',
        'レッツゴー！陰陽師',
        '陰陽師　安倍　晴明風　  男性M    コスプレ衣装　 　完全オーダメイドも対応',
        '陰陽師  彰子風　  女性M    コスプレ衣装　 　完全オーダメイドも対応'
      ]
    end
    let(:product_image_urls) do
      %w[
        http://ecx.images-amazon.com/images/I/51H24893PSL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/31GhQQVVoEL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/31ZFo3xRGtL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/51Akr-jxa2L._AA178_.jpg
        http://ecx.images-amazon.com/images/I/61so4UfAVtL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/41RGc7k2rUL._AA178_.jpg
        http://ecx.images-amazon.com/images/I/41DecVejRuL._AA178_.jpg
      ]
    end
    let(:makers) do
      ['学研マーケティング', 'ゲーム・サントラ,矢部野彦磨&琴姫 With 坊主ダンサー,秋葉原三人娘,惑星ペンダギンのサダ吉とその仲間達,無一文隼人', 'エキサイト', 'プレイモア', 'Ｎｅ−Ｈｏ', 'LUGANO', 'LUGANO'
      ]
    end
    let(:buy_nums){ [12, 340, 28, 0, 0, 0, 0] }
    let(:clicked_nums){ [237, 22631, 43985, 1414, 225, 0, 0] }
    let(:clicked_at_this_movies){ [7, 1, 3, 2, 1, 0, 0] }
    let(:actual){ ApiAdapter.get_market_info 'sm9' }

    def actual_attr(attribute)
      actual.map{ |h| h[attribute] }
    end

    before do
      stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
    end

    it 'shop_idたちを取得できる' do
      expect(actual_attr :shop_id).to eq Array.new(7, 1)
    end

    it 'product_idたちを取得できる' do
      expect(actual_attr :product_id).to eq product_ids
    end

    it 'product_namesたちを取得できる' do
      expect(actual_attr :product_name).to eq product_names
    end

    it 'product_image_urlたちを取得できる' do
      expect(actual_attr :product_image_url).to eq product_image_urls
    end

    it 'makerたちを取得できる' do
      expect(actual_attr :maker).to eq makers
    end

    it 'buy_numたちを取得できる' do
      expect(actual_attr :buy_num).to eq buy_nums
    end

    it 'clicked_numたちを取得できる' do
      expect(actual_attr :clicked_num).to eq clicked_nums
    end

    it 'clicked_at_this_movieたちを取得できる' do
      expect(actual_attr :clicked_at_this_movie).to eq clicked_at_this_movies
    end
  end
end