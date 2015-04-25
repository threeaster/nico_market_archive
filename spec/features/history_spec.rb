require 'rails_helper'

feature 'history' do
  subject{ page }
  let(:movie){ create :movie, movie_id: 'sm9' }
  background do
    stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
    visit movie_path movie.id
  end

  feature 'movieページからhistoryページヘリンクから飛べる' do
    it 'historyの日付が表示されて、そこからhistoryページに飛べる' do
      should have_content movie.histories[0].date
      click_link movie.histories[0].date
      expect(current_path).to eq history_path movie.histories[0].id
    end
  end
end