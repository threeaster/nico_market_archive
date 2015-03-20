require 'rails_helper'

feature '登録' do
  feature 'トップからフォームで正しい未登録の動画IDが投げられる' do
    let(:movie_id){ 'sm9' }
    background do
      visit root_path
      fill_in 'movie_movie_id', with: movie_id
      click_button '保管'
    end

    scenario { expect(Movie.first.movie_id).to eq movie_id }
    
    scenario { expect(current_path).to eq movie_path Movie.first.id }
  end
end