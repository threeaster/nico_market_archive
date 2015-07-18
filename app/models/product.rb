class Product < ActiveRecord::Base
  has_and_belongs_to_many :histories
  enum shop_id: { amazon: 1 }


  def product_id_for_url
    product_id.sub('az', '')
  end
end
