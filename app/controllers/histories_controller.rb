class HistoriesController < ApplicationController
  def show
    if history = History.find_history_by_time(params[:history])
      redirect_to history_path history.id
    end
    @history = History.find(params[:id])
    @movie_id = Movie.find(@history.movie_id).movie_id
    @products = @history.products
    @date_params = @history.date_params
    @now_date = @history.date.strftime '%Y年%-m月%-d日　%-H:%-M'
  end

  [:months, :days, :hours, :minutes].each do |part|
    define_method(part) do
      if (params && parts = History.send(part, params))
        render json: parts
      else
        render nothing: true, status: 400
      end
    end
  end
end
