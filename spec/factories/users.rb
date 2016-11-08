FactoryGirl.define do
  factory :user do
    first_name 'James'
    last_name 'Sanders'
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@mail.com" }
    password 'secret'
    password_confirmation 'secret'
    date_of_birth Date.new(1990, 4, 20)
    phone 1123456789
    website 'https://google.com'
  end
end
