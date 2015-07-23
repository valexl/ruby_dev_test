# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:random_title)   { "#{Forgery('name').company_name}" }
  sequence(:random_content) { Forgery('lorem_ipsum').paragraphs }
end
