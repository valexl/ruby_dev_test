require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.build(:user)
  end
  
  it 'will successfuly save if build from FactoryGirl' do
    expect(@user.save!).to eq(true)
  end

  it 'will set user as admin if this user is first' do
    User.destroy_all
    @user.admin = false
    @user.save!
    expect(@user.admin?).to eq(true)
  end

  it 'will not set user as admin if this user does not first' do
    FactoryGirl.create(:user)
    @user.admin = false
    @user.save!
    expect(@user.admin?).to eq(false)
  end


end
