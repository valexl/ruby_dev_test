FactoryGirl.define do
  factory :comment do
    content  { generate :random_content }
    association :post, factory: :post    
    association :user, factory: :user    
  end

end
