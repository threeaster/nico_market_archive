class Product < ActiveRecord::Base
  has_and_belongs_to_many :history
  enum shop_id: { amazon: 1 }
end
