require 'rails_helper'
describe ApiAdapter do
  describe '.get_market_info' do
    let(:expected) do
      product_ids = %w[4056000816 B000P5FHCQ B000CQCOLA B00014B10S B0044BIQDO B009K2N4FW B009K2QJ0E]
      product_ids.map{ |product_id| { shop_id: 1, product_id: product_id } }
    end

    before do
      stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
    end

    it '与えられた動画IDに対して、その市場に登録されている商品の店舗IDと商品IDのhashの配列が帰ってくる' do
      expect(ApiAdapter.get_market_info 'sm9').to eq expected
    end
  end
end