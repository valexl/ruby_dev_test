require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = FactoryGirl.build(:comment)
  end

  it 'will succssful save if builds from FactoryGirl' do
    expect(@comment.save!).to eq(true)
  end

  it 'will not save if has blank post' do
    @comment.post = nil
    expect(@comment.save).to eq(false)
  end

end
