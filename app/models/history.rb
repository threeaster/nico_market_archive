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
end
