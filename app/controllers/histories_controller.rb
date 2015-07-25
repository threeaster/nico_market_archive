class HistoriesController < ApplicationController
  def show
    history = History.find(params[:id])
    @movie_id = Movie.find(history.movie_id).movie_id
    @products = history.products
  end
end
