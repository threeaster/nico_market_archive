require 'rails_helper'

feature '登録' do
  subject{ page }
  background do
    stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
    stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm09").to_return(:status => 200, :body => page_file('sm09_market.json')) #テスト用で、実際には存在しないID
  end

  feature 'トップからフォームで正しい未登録の動画IDが投げられ、そのshowページにアクセスする' do
    let(:movie_id){ 'sm9' }
    background do
      visit root_path
      fill_in 'movie_movie_id', with: movie_id
      click_button '保管'
    end

    scenario { expect(Movie.first.movie_id).to eq movie_id }
    
    scenario { expect(current_path).to eq movie_path Movie.first.id }
  end

  feature '作成済みの動画のshowページに来ると、その動画の市場情報が登録される' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    background do
      visit movie_path movie.id
    end

    scenario { expect(movie.products.count).to eq 7 }

    scenario { expect(movie.products.first.product_id).to eq 'az4056000816' }
  end

  feature '作成済みの動画のshowページに来ると、その動画の市場情報が見れる' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    background do
      visit movie_path movie.id
    end

    scenario { should have_content 'az4056000816' }
  end

  feature '登録済みの商品があるときは商品を作らず、historyだけが増える' do
    let(:before_movie){ create :movie, movie_id: 'sm09' }
    let(:movie){ create :movie, movie_id: 'sm9' }
    background do
      visit movie_path before_movie.id
      visit movie_path movie.id
    end

    scenario { expect(Product.count).to eq 7 }

    scenario '各回の商品数が正しい' do
      histories = History.all
      expect(histories[0].products.count).to eq 6
      expect(histories[1].products.count).to eq 7
    end
  end
end