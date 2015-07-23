FactoryGirl.define do
  factory :post do
    title    { generate :random_title }
    content  { generate :random_content }
    association :category, factory: :category    
  end

end
