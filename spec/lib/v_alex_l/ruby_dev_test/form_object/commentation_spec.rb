require 'rails_helper'

RSpec.describe VAlexL::RubyDevTest::FormObject::Commentation do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @post = FactoryGirl.create(:post)
  end

  before(:each) do
    @commentation = VAlexL::RubyDevTest::FormObject::Commentation.new post_id: @post.id, user_id: @user.id, content: '...'
  end

  describe 'has_method valid?' do
    context 'will return false if' do
      after(:each) do
        expect(@commentation.valid?).to eq(false)
      end

      it 'has blank content' do
        @commentation.content = nil
      end

      it 'has blank post_id' do
        @commentation.post_id = nil
      end

      it 'has blank @user and blank captcha' do
        @commentation.user_id = nil
        @commentation.captcha = nil
      end

      it 'has blank @user and incorect captcha' do
        @commentation.user_id = nil
        @commentation.captcha = 'incorect'
      end
    end

    context 'will return true if' do
      after(:each) do
        expect(@commentation.valid?).to eq(true)
      end

      it 'has blank user_id and captcha equal "one"' do
        @commentation.user_id = nil
        @commentation.captcha = 'one'
      end

      it 'has blank user_id and captcha equal "1"' do
        @commentation.user_id = nil
        @commentation.captcha = '1'
      end
    end
  end

  describe 'has method save' do
    context 'if valid? true' do
      it 'will return true' do
        allow(@commentation).to receive(:valid?).and_return(true)
        expect(@commentation.save).to eq(true)
      end

      it 'will create new comment' do
        allow(@commentation).to receive(:valid?).and_return(true)
        expect {
          @commentation.save
        }.to change(Comment, :count).by(1)
      end
    end
    context 'if valid? false' do
      it 'will return false' do
        allow(@commentation).to receive(:valid?).and_return(false)
        expect(@commentation.save).to eq(false)
      end

      it 'will create new comment' do
        allow(@commentation).to receive(:valid?).and_return(false)
        expect {
          @commentation.save
        }.not_to change(Comment, :count)
      end

    end

  end
end