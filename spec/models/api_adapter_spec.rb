require 'rails_helper'
describe ApiAdapter do
  describe '.get_market_info' do
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