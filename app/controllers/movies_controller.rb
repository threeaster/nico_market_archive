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
    @history = movie.histories.order(date: :desc).first
    unless @history && @history.recently_registerd?
      @history = History.create movie: movie, date: Time.now
      @history.register_products(market_info)
    end
    @products = @history.products
    @date_params = @history.date_params
    @now_date = @history.date.strftime '%Y年%-m月%-d日　%-H:%-M'
    gon.movie_id = movie.id
    render template: 'histories/show'
  end

  def show_all

  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
