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
    Time.now - created_at < TIMESPAN
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

  def self.years(params = {})
    History.all.order(:date).map{ |h| h.date.strftime '%Y' }.uniq
  end

  def self.months(params)
    origin = Time.new(params[:year], 1, 1, 0, 0, 0)
    History.where('? <= date and date <= ?', origin, origin.end_of_year).order(:date).map{ |h| h.date.strftime '%-m' }.uniq
  end

  def self.days(params)
    origin = Time.new(params[:year], params[:month], 1, 0, 0, 0)
    History.where('? <= date and date <= ?', origin, origin.end_of_month).order(:date).map{ |h| h.date.strftime '%-d' }.uniq
  end

  def self.hours(params)
    origin = Time.new(params[:year], params[:month], params[:day], 0, 0, 0)
    History.where('? <= date and date <= ?', origin, origin.end_of_day).order(:date).map{ |h| h.date.strftime '%-H' }.uniq
  end

  def self.minutes(params)
    origin = Time.new(params[:year], params[:month], params[:day], params[:hour], 0, 0)
    History.where('? <= date and date <= ?', origin, origin.end_of_hour).order(:date).map{ |h| h.date.strftime '%-M' }.uniq
  end
end
