class HistoriesController < ApplicationController
  def show
    @products = History.find(params[:id]).products
  end
end
