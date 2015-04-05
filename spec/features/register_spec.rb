require 'rails_helper'

feature '登録' do
  subject{ page }
  background do
    stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
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

    scenario { expect(movie.products.first.product_id).to eq '4056000816' }
  end

  feature '作成済みの動画のshowページに来ると、その動画の市場情報が見れる' do
    let(:movie){ create :movie, movie_id: 'sm9' }
    background do
      visit movie_path movie.id
    end

    scenario { should have_content '4056000816' }
  end
end