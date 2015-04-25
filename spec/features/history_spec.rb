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
      should have_content movie.histories[0].date
      click_link movie.histories[0].date
      expect(current_path).to eq history_path movie.histories[0].id
    end
  end

  feature '個別のhistoryページで、その時の商品の情報が見れる' do
    it 'product_id' do
      visit history_path movie.histories[0].id
      ["az4056000816", "azB000P5FHCQ", "azB000CQCOLA", "azB00014B10S", "azB0044BIQDO", "azB009K2N4FW"].each do |product_id|
        should have_content product_id
      end
      should_not have_content "azB009K2QJ0E"
    end
  end
end