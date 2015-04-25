class History < ActiveRecord::Base
  has_and_belongs_to_many :products
  belongs_to :movie

  def register_products(products_info)
    products_info.each do |product_info|
      products = Product.where(product_id: product_info[:product_id])
      if products.count > 0
        product = products[0]
      else
        product = Product.create shop_id: product_info[:shop_id], product_id: product_info[:product_id]
      end
      product.histories << self
    end
  end
end
