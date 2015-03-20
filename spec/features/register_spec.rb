require 'rails_helper'

feature '登録' do
  feature 'トップからフォームで正しい未登録の動画IDが投げられる' do
    scenario 'movieデータベースに登録される' do
      movie_id = 'sm9'
      visit root_path
      fill_in 'movie_movie_id', with: movie_id
      click_button '保管'
      expect(Movie.first.movie_id).to eq movie_id
    end
  end
end