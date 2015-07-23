FactoryGirl.define do
  factory :category do
    title  { generate :random_title }
    parent_id nil
  end

end
