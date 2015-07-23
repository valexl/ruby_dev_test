require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @post = FactoryGirl.build(:post)
  end

  describe 'successfuly saves if' do
    after(:each) do
      expect(@post.save!).to eq(true)
    end
    
    it 'builds from FactoryGirl' do
    end
    
    it 'has blank category and has unpublished status' do
      @post.category  = nil
      @post.published = false
    end
  end

  describe 'will not save if' do
    after(:each) do
      expect(@post.save).to eq(false)
    end

    it 'has blank title' do
      @post.title = nil
    end

    it 'has blank category and published true' do
      @post.published = true
      @post.category = nil
    end

  end

end
