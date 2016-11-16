FactoryGirl.define do
  factory :vote do
    association :user, factory: :user
    association :post, factory: :post
    association :comment, factory: :comment
  end
end
