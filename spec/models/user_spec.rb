require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it 'successfuly saves if build from FactoryGirl' do
    expect(@user.save!).to eq(true)
  end
  
end
