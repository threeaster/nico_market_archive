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
      click_button '保管＆検索'
    end

    scenario { expect(Movie.first.movie_id).to eq movie_id }
    
    scenario { expect(current_path).to eq movie_path Movie.first.id }
  end

  feature '作成済みの動画idを再度投げられた時は新たに作成せず、あるものをもってくる' do
    background do
      visit root_path
      fill_in 'movie_movie_id', with: 'sm9'
      click_button '保管＆検索'
      visit root_path
      fill_in 'movie_movie_id', with: 'sm9'
      click_button '保管＆検索'
    end

    scenario { expect(Movie.count).to eq 1 }
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

    scenario { should have_content product_names[0] }
    scenario { should have_content makers[0] }
    scenario { should have_content buy_nums[0] }
    scenario { should have_content clicked_nums[0] }
    scenario { should have_content clicked_at_this_movies[0] }
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

  feature '直近の登録時間によって登録されるかが決まる' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    background do
      Timecop.freeze
    end

    feature '直近が10分前だった時' do
      background do
        Timecop.travel 10.minutes.ago
        visit movie_path movie.id
        Timecop.return
      end

      scenario '改めて登録される' do
        visit movie_path movie.id
        expect(History.count).to eq 2
      end
    end

    feature '直近が9分30秒だった時' do
      background do
        Timecop.travel (10.minutes.ago + 30)
        visit movie_path movie.id
        Timecop.return
      end

      scenario '登録されない' do
        visit movie_path movie.id
        expect(History.count).to eq 1
      end
    end
  end
end