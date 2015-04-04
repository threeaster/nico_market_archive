FactoryGirl.define do
  factory :product do
    sequence(:product_id){ |n| "#{n}" }
    shop_id 1
  end
end
