class MoviesController < ApplicationController
  def index
  end

  def create
    unless movie = Movie.where(movie_id: movie_params[:movie_id]).first
      movie = Movie.create movie_params
    end
    redirect_to movie_path movie.id
  end

  def show
    movie = Movie.find params[:id]
    @movie_id = movie.movie_id
    market_info = ApiAdapter.get_market_info movie.movie_id
    last_history = movie.histories.order(id: :desc).first
    unless last_history && last_history.recently_registerd?
      last_history = History.create movie: movie, date: Time.now
      last_history.register_products(market_info)
    end
    @products = last_history.products
    render template: 'histories/show'
  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
