FactoryGirl.define do
  factory :user do
    email { generate :random_email }
    password 11223344
    password_confirmation 11223344
  end

end
