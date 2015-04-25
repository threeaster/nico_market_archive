class MoviesController < ApplicationController
  def index
    @movie = Movie.new
  end

  def create
    movie = Movie.create movie_params
    redirect_to movie_path movie.id
  end

  def show
    movie = Movie.find params[:id]
    @market_info = ApiAdapter.get_market_info movie.movie_id
    history = History.create movie: movie, date: Time.now
    @market_info.each do |product_info|
      products = Product.where(product_id: product_info[:product_id])
      if products.count > 0
        product = products[0]
      else
        product = Product.create shop_id: product_info[:shop_id], product_id: product_info[:product_id]
      end
      product.histories << history
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
