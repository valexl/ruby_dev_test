FactoryGirl.define do
  factory :comment do
    content  { generate :random_content }
    status Comment::PENDING
    association :post, factory: :post    
    association :user, factory: :user    
  end

end
