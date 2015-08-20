require 'rails_helper'
describe '時間のAPI', type: :request do
  subject{ JSON.parse(response.body) }
  before do
    generate_histories
  end

  shared_examples '共通仕様' do |part|
    let(:params){
      [:year, :month, :day, :hour, :minute].inject([]){ |h_a, time|
        break h_a if time == part
        h_a << [time, now_history.send(time)]
      }.to_h.merge(movie_id: movie.id)
    }
    let(:parts){ "#{part}s".to_sym }
    describe '条件を満たす動画IDと日付データを渡した時' do
      before do
        get send("#{parts}_histories_path", params)
      end

      it{ expect(JSON.parse(response.body)).to eq send("correct_#{parts}") }
      it{ expect(response.status).to eq 200 }
    end

    describe 'パラメータが足りない時' do
      before do
        get send("#{parts}_histories_path")
      end

      it{ expect(response.body).to eq '' }
      it{ expect(response.status).to eq 400 }
    end
  end

  [:month, :day, :hour, :minute].each do |part|
    describe "#{part}s" do
      it_behaves_like '共通仕様', part
    end
  end
end