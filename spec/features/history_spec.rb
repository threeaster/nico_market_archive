require 'rails_helper'

feature 'history' do
  subject{ page }
  let(:movie){ create :movie, movie_id: 'sm09' }
  let(:now_history){ History.create! movie: movie, date: Time.new }

  shared_examples '共通' do
    feature '個別のhistoryページで、その時の商品の情報が見れる' do
      scenario { should have_title movie.movie_id }
      scenario { should have_content product_names[0] }
      scenario { should have_content makers[0] }
      scenario { should have_content buy_nums[0] }
      scenario { should have_content clicked_nums[0] }
      scenario { should have_content clicked_at_this_movies[0] }
    end

    feature '選択中のhistoryの時間がセレクトボックスに入っている' do
      scenario { should have_select :history_year, selected: now_history.date.strftime('%Y') }
      scenario { should have_select :history_month, selected: now_history.date.strftime('%-m') }
      scenario { should have_select :history_day, selected: now_history.date.strftime('%-d') }
      scenario { should have_select :history_hour, selected: now_history.date.strftime('%-H') }
      scenario { should have_select :history_minute, selected: now_history.date.strftime('%-M') }
    end
  end

  feature 'movieページ' do
    background do
      stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm09").to_return(:status => 200, :body => page_file('sm09_market.json'))
      visit movie_path movie.id
    end

    it_behaves_like '共通'
  end

  feature 'historyページ' do
    background do
      register_products now_history
      visit history_path now_history.id
    end

    it_behaves_like '共通'
  end
end