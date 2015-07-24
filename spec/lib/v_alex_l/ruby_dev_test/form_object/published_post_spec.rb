require 'rails_helper'

RSpec.describe VAlexL::RubyDevTest::FormObject::PublishedPost do
  before(:each) do
    @category  = FactoryGirl.create(:category)
    @post      = FactoryGirl.create(:post, published: false)
    @post_form = VAlexL::RubyDevTest::FormObject::PublishedPost.new post: @post, category_id: @category.id, tag_list: "first, second"
  end

  it 'will give category_id from @post if category_id blank' do
    @post_form = VAlexL::RubyDevTest::FormObject::PublishedPost.new post: @post, tag_list: "first, second"
    expect(@post_form.category_id).to eq(@post.category_id)
  end

  it 'will give tag_list from @post if tag_list blank' do
    @post_form = VAlexL::RubyDevTest::FormObject::PublishedPost.new post: @post, category_id: @category.id
    expect(@post_form.tag_list).to eq(@post.tag_list)
  end
  
  describe 'has method apply!. It' do
    it 'changes published from false to true and returns true' do
      expect(@post_form.apply!).to eq(true)
      @post.reload
      expect(@post.published?).to eq(true)
    end

    it 'will return false and will not change published if blank category' do
      @post_form.category_id = nil
      expect(@post_form.apply!).to eq(false)
      @post.reload
      expect(@post.published?).to eq(false)
    end

    it 'will return false and will not change published if blank tag_list' do
      @post_form.tag_list = ''
      expect(@post_form.apply!).to eq(false)
      @post.reload
      expect(@post.published?).to eq(false)
    end
  end

end
