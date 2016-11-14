FactoryGirl.define do
  factory :comment do
    body 'A test commentary.'
    upvotes 0
    association :post, factory: :post
    association :user, factory: :user
  end
end
