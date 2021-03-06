class History < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :movie
  TIMESPAN = 10.minutes

  def register_products(products_info)
    products_info.each do |product_info|
      products = Product.where(product_id: product_info[:product_id])
      if products.count > 0
        product = products[0]
      else
        product = Product.create product_info
      end
      product.histories << self
    end
  end

  def recently_registerd?
    Time.now - date < TIMESPAN
  end

  def year
    date.strftime '%Y'
  end

  def month
    date.strftime '%-m'
  end

  def day
    date.strftime '%-d'
  end

  def hour
    date.strftime '%-H'
  end

  def minute
    date.strftime '%-M'
  end

  def date_params
    %i[year month day hour minute movie_id].map{ |sym| [sym, send(sym)] }.to_h
  end

  def self.years(params = {})
    return nil unless params[:movie_id]
    History.where(movie_id: params[:movie_id]).order(:date).map{ |h| h.date.strftime '%Y' }.uniq
  end

  def self.months(params)
    return nil unless (params[:movie_id] && params[:year])
    origin = Time.new(params[:year], 1, 1, 0, 0, 0)
    History.where(movie_id: params[:movie_id]).where('? <= date and date <= ?', origin, origin.end_of_year).order(:date).map{ |h| h.date.strftime '%-m' }.uniq
  end

  def self.days(params)
    return nil unless(params[:movie_id] && params[:year] and params[:month])
    origin = Time.new(params[:year], params[:month], 1, 0, 0, 0)
    History.where(movie_id: params[:movie_id]).where('? <= date and date <= ?', origin, origin.end_of_month).order(:date).map{ |h| h.date.strftime '%-d' }.uniq
  end

  def self.hours(params)
    return nil unless(params[:movie_id] && params[:year] and params[:month] and params[:day])
    origin = Time.new(params[:year], params[:month], params[:day], 0, 0, 0)
    History.where(movie_id: params[:movie_id]).where('? <= date and date <= ?', origin, origin.end_of_day).order(:date).map{ |h| h.date.strftime '%-H' }.uniq
  end

  def self.minutes(params)
    return nil unless(params[:movie_id] && params[:year] and params[:month] and params[:day] and params[:hour])
    origin = Time.new(params[:year], params[:month], params[:day], params[:hour], 0, 0)
    History.where(movie_id: params[:movie_id]).where('? <= date and date <= ?', origin, origin.end_of_hour).order(:date).map{ |h| h.date.strftime '%-M' }.uniq
  end

  def self.find_history_by_time(params)
    unless params && (%w[year month day hour minute] - params.keys).empty?
      return nil
    end
    date = Time.new(params['year'], params['month'], params['day'], params['hour'], params['minute'])
    history = History.where('? <= date and date <= ?', date.beginning_of_minute, date.end_of_month).first
    history
  end
end
