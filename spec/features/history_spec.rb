require 'rails_helper'

feature 'history' do
  subject{ page }

  background do
    Timecop.freeze Time.new(2015, 12, 31, 23, 30, 0)
    generate_histories
  end

  after do
    Timecop.return
  end

  shared_examples '共通' do
    feature '個別のhistoryページで、その時の商品などのの情報が見れる' do
      scenario { should have_title movie.movie_id }
      scenario { should have_content now_history.date.strftime '%Y年%-m月%-d日　%-H:%-Mの市場' }
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

    feature '各セレクトボックスにはその前までが現在のhistoryと一致している、同じ動画についてのhistoryの者達が入っている' do
      scenario { expect(page.all('#history_year option').map{ |opt| opt[:value] }).to eq correct_years }
      scenario { expect(page.all('#history_month option').map{ |opt| opt[:value] }).to eq correct_months }
      scenario { expect(page.all('#history_day option').map{ |opt| opt[:value] }).to eq correct_days }
      scenario { expect(page.all('#history_hour option').map{ |opt| opt[:value] }).to eq correct_hours }
      scenario { expect(page.all('#history_minute option').map{ |opt| opt[:value] }).to eq correct_minutes }
    end

    feature 'ボタンを押すとセレクトボックスに選ばれた時間のhistoryページにジャンプする' do
      background do
        @before_history.date
        select '5', from: :history_minute
        click_button '市場を見る'
      end

      scenario { expect(current_path).to eq history_path @before_history.id }
    end

    feature '時間選ぶとその直後だけが選択可能になる', js: true do
      feature '年を選ぶ' do
        background do
          select '2014', from: :history_year
          find("#history_month option[value='1']")
        end

        scenario { expect(page.all('#history_month option').map{ |opt| opt[:value] }).to eq %w[1 2] }
        scenario { expect(find('#history_year')['disabled']).to be_falsy }
        scenario { expect(find('#history_month')['disabled']).to be_falsy }
        scenario { expect(find('#history_day')['disabled']).to be_truthy }
        scenario { expect(find('#history_hour')['disabled']).to be_truthy }
        scenario { expect(find('#history_minute')['disabled']).to be_truthy }
        scenario { expect(find('#jump_to_history_time')['disabled']).to be_truthy }
      end

      feature '月を選ぶ' do
        background do
          select '2014', from: :history_year
          find("#history_month option[value='1']")
          select '2015', from: :history_year
          find("#history_month option[value='#{correct_months.first}']")
          select '2', from: :history_month
          find("#history_day option[value='1']")
        end

        scenario { expect(page.all('#history_day option').map{ |opt| opt[:value] }).to eq %w[1 2] }
        scenario { expect(find('#history_year')['disabled']).to be_falsy }
        scenario { expect(find('#history_month')['disabled']).to be_falsy }
        scenario { expect(find('#history_day')['disabled']).to be_falsy }
        scenario { expect(find('#history_hour')['disabled']).to be_truthy }
        scenario { expect(find('#history_minute')['disabled']).to be_truthy }
        scenario { expect(find('#jump_to_history_time')['disabled']).to be_truthy }
      end

      feature '日を選ぶ' do
        background do
          select '2014', from: :history_year
          find("#history_month option[value='1']")
          select '2015', from: :history_year
          find("#history_month option[value='#{correct_months.first}']")
          select '2', from: :history_month
          find("#history_day option[value='1']")
          select '12', from: :history_month
          find("#history_day option[value='#{correct_days.first}']")
          select '3', from: :history_day
          find("#history_hour option[value='1']")
        end

        scenario { expect(page.all('#history_hour option').map{ |opt| opt[:value] }).to eq %w[1 2] }
        scenario { expect(find('#history_year')['disabled']).to be_falsy }
        scenario { expect(find('#history_month')['disabled']).to be_falsy }
        scenario { expect(find('#history_day')['disabled']).to be_falsy }
        scenario { expect(find('#history_hour')['disabled']).to be_falsy }
        scenario { expect(find('#history_minute')['disabled']).to be_truthy }
        scenario { expect(find('#jump_to_history_time')['disabled']).to be_truthy }
      end

      feature '時間を選ぶ' do
        background do
          select '2014', from: :history_year
          find("#history_month option[value='1']")
          select '2015', from: :history_year
          find("#history_month option[value='#{correct_months.first}']")
          select '2', from: :history_month
          find("#history_day option[value='1']")
          select '12', from: :history_month
          find("#history_day option[value='#{correct_days.first}']")
          select '3', from: :history_day
          find("#history_hour option[value='1']")
          select '31', from: :history_day
          find("#history_hour option[value='#{correct_hours.first}']")
          select '4', from: :history_hour
          find("#history_minute option[value='1']")
        end

        scenario { expect(page.all('#history_minute option').map{ |opt| opt[:value] }).to eq %w[1 2] }
        scenario { expect(find('#history_year')['disabled']).to be_falsy }
        scenario { expect(find('#history_month')['disabled']).to be_falsy }
        scenario { expect(find('#history_day')['disabled']).to be_falsy }
        scenario { expect(find('#history_hour')['disabled']).to be_falsy }
        scenario { expect(find('#history_minute')['disabled']).to be_falsy }
        scenario { expect(find('#jump_to_history_time')['disabled']).to be_falsy }
      end
    end
  end

  feature 'movieページ' do
    background do
      stub_request(:get, "http://ichiba.nicovideo.jp/embed/zero/show_ichiba?v=sm9").to_return(:status => 200, :body => page_file('sm9_market.json'))
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