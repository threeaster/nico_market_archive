FactoryGirl.define do
  factory :movie do
    sequence(:movie_id){ |n| "sm#{n}" }
  end
end
