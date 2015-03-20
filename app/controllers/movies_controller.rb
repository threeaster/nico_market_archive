class MoviesController < ApplicationController
  def index
    @movie = Movie.new
  end

  def create
    movie = Movie.create movie_params
    redirect_to movie_path movie.id
  end

  def show

  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id)
  end
end
