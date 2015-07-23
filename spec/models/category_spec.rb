require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = FactoryGirl.build(:category)
  end

  it 'successful save if build from FactoryGirl' do
    expect(@category.save!).to eq(true)
  end

  it 'will not save if blank title' do
    @category.title = nil
    expect(@category.save).to eq(false)
  end

end
