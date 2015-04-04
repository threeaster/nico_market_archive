class Movie < ActiveRecord::Base
  has_many :histories
  has_many :products, through: :histories
end
