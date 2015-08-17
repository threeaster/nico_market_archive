class HistoriesController < ApplicationController
  def show
    @history = History.find(params[:id])
    @movie_id = Movie.find(@history.movie_id).movie_id
    @products = @history.products
    @date_params = @history.date_params
    @now_date = @history.date.strftime '%Y年%-m月%-d日　%-H:%-M'
  end
end
