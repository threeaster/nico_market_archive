require 'rails_helper'

feature 'history' do
  subject{ page }
  let(:movie){ create :movie, movie_id: 'sm09' }
  background do
    stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm09").to_return(:status => 200, :body => page_file('sm09_market.json'))
    visit movie_path movie.id
  end

  feature 'movieページからhistoryページヘリンクから飛べる' do
    it 'historyの日付が表示されて、そこからhistoryページに飛べる' do
      pending
      should have_content movie.histories[0].date
      click_link movie.histories[0].date
      expect(current_path).to eq history_path movie.histories[0].id
    end
  end

  feature '個別のhistoryページで、その時の商品の情報が見れる' do
    scenario { should have_title movie.movie_id }
    scenario { should have_content product_names[0] }
    scenario { should have_content makers[0] }
    scenario { should have_content buy_nums[0] }
    scenario { should have_content clicked_nums[0] }
    scenario { should have_content clicked_at_this_movies[0] }
  end
end