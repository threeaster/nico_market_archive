class MoviesController < ApplicationController
  def index
    @movie = Movie.new
  end

  def create
    Movie.create movie_params
    render text: movie_params.inspect
  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
