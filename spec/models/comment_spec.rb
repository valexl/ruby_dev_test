require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = FactoryGirl.build(:comment)
  end

  describe 'will succssful save if ' do
    after(:each) do
      expect(@comment.save!).to eq(true)
    end
    
    it 'builds from FactoryGirl' do
    end

    Comment::STATUSES.each do |status|
      it "has status equal #{status}" do
        @comment.status = status
      end
    end

  end
  

  describe 'will not save if' do
    after(:each) do
      expect(@comment.save).to eq(false)
    end

    it 'has blank post' do
      @comment.post = nil
    end

    it 'has inccorect status' do
      @comment.status = 'inccorect'
    end
  end

  describe 'has method' do
    Comment::STATUSES.each do |status|
      it "#{status}! which set status to #{status}" do
        @comment.send("#{status}!")
        expect(@comment.status).to eq(status)
      end

      it "is_#{status}? which return true if status equal #{status}" do
        @comment.status = nil
        expect(@comment.send("is_#{status}?")).to eq(false)
        @comment.status = status
        expect(@comment.send("is_#{status}?")).to eq(true)
      end
    end

  end


end
