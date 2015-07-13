class MoviesController < ApplicationController
  def index
  end

  def create
    movie = Movie.create movie_params
    redirect_to movie_path movie.id
  end

  def show
    movie = Movie.find params[:id]
    @market_info = ApiAdapter.get_market_info movie.movie_id
    history = History.create movie: movie, date: Time.now
    history.register_products(@market_info)
    @histories = movie.histories
  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
