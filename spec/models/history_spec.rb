require 'rails_helper'

RSpec.describe History, :type => :model do
  describe '#register_products' do
    let(:market_info) do
      [{:shop_id=>1, :product_id=>"az4056000816"},
      {:shop_id=>1, :product_id=>"azB000P5FHCQ"},
      {:shop_id=>1, :product_id=>"azB000CQCOLA"},
      {:shop_id=>1, :product_id=>"azB00014B10S"},
      {:shop_id=>1, :product_id=>"azB0044BIQDO"},
      {:shop_id=>1, :product_id=>"azB009K2N4FW"},
      {:shop_id=>1, :product_id=>"azB009K2QJ0E"}]
    end
    let(:movie){ create :movie, movie_id: 'sm9' }
    let(:history){ History.create movie: movie, date: Time.now }

    it '商品情報がhistoryに登録される' do
      history.register_products market_info
      expect(history.products.map{ |p| p[:product_id] }).to match_array market_info.map{ |p| p[:product_id] }
    end

    it '登録済みの商品と未登録のの賞品が渡された時、商品が重複作成されず、正しく登録される' do
      history.register_products market_info[1..-1]
      history2 = History.create movie: movie, date: Time.now
      history2.register_products market_info[0..-2]
      expect(Product.count).to eq 7
      expect(history.products.map{ |p| p[:product_id] }).to match_array market_info[1..-1].map{ |p| p[:product_id] }
      expect(history2.products.map{ |p| p[:product_id] }).to match_array market_info[0..-2].map{ |p| p[:product_id] }
    end
  end
end
