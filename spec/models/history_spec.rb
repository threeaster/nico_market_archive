require 'rails_helper'

RSpec.describe History, :type => :model do
  describe '#register_products' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    let(:history){ History.create movie: movie, date: Time.now }

    describe '商品情報がhistoryに登録される' do
      before do
        history.register_products market_info
      end

      it{ expect(history.products.map{ |p| p[:shop_id] }).to match_array shop_ids }
      it{ expect(history.products.map{ |p| p[:product_id] }).to match_array product_ids }
      it{ expect(history.products.map{ |p| p[:product_name] }).to match_array product_names }
      it{ expect(history.products.map{ |p| p[:product_image_url] }).to match_array product_image_urls }
      it{ expect(history.products.map{ |p| p[:maker] }).to match_array makers }
      it{ expect(history.products.map{ |p| p[:buy_num] }).to match_array buy_nums }
      it{ expect(history.products.map{ |p| p[:clicked_num] }).to match_array clicked_nums }
      it{ expect(history.products.map{ |p| p[:clicked_at_this_movie] }).to match_array clicked_at_this_movies }
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

  describe '時間関係のgetter' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    let(:year){ '2015' }
    let(:month){ '1' }
    let(:day){ '2' }
    let(:hour){ '3' }
    let(:minute){ '4' }
    let(:history){ History.create movie: movie, date: Time.new(year, month, day, hour, minute, 0) }
    it{ expect(history.year).to eq year }
    it{ expect(history.month).to eq month }
    it{ expect(history.day).to eq day }
    it{ expect(history.hour).to eq hour }
    it{ expect(history.minute).to eq minute }
  end

  describe '指定された時間を含む期間に登録されている同じ動画のhistoryの時間を取得' do
    describe '正常なパラメータの時' do
      let(:movie){ create :movie, movie_id: 'sm9' }
      let(:params){ { year: 2015, month: 4, day: 27, hour: 18, minute: 30, movie_id: movie.id } }
      before do
        dummy_movie = create :movie, movie_id: 'sm12'
        [
          [2016, 11, 20, 22, 55, 0],
          [2015, 5, 29, 21, 50, 0],
          [2015, 4, 28, 20, 45, 0],
          [2015, 4, 27, 19, 40, 0],
          [2015, 4, 27, 18, 35, 0],
          [2015, 4, 27, 18, 30, 0]
        ].each_with_index do |time, i|
          History.create movie: movie, date: Time.new(*time)
          History.create movie: dummy_movie, date: Time.new(*time.tap{ |t| t[i] += 1 })
        end
      end

      it{ expect(History.years params).to eq %w[2015 2016] }
      it{ expect(History.months params).to eq %w[4 5] }
      it{ expect(History.days params).to eq %w[27 28] }
      it{ expect(History.hours params).to eq %w[18 19] }
      it{ expect(History.minutes params).to eq %w[30 35] }
    end

    describe 'パラメータが無いとき' do
      let(:params){ {} }
      it{ expect(History.years params).to be_nil }
      it{ expect(History.months params).to be_nil }
      it{ expect(History.days params).to be_nil }
      it{ expect(History.hours params).to be_nil }
      it{ expect(History.minutes params).to be_nil }
    end
  end

  describe '::find_history_by_time' do
    let!(:history){ History.create date: Time.new(2015, 1, 1, 1, 1, 0) }

    it 'パラメータが足りないときnilが返る' do
      expect(History.find_history_by_time 'year' => 2015).to be_nil
    end

    it '存在するhistoryの時間のhashを渡すとhistoryがかえってくる' do
      expect(History.find_history_by_time 'year' => 2015, 'month' => 1, 'day' => 1, 'hour' => 1, 'minute' => 1).to eq history
    end

    it '存在しないhistoryの時間をhashで渡すとnilがかえってくる' do
      expect(History.find_history_by_time 'year' =>  2015, 'month' => 1, 'day' => 2, 'hour' => 3, 'minute' => 4).to be_nil
    end
  end
end
