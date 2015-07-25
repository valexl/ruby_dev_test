require 'rails_helper'

describe VAlexL::RubyDevTest::Searcher::PostSearcher do
  before(:all) do
    Post.delete_all
    Category.delete_all
    Post.__elasticsearch__.delete_index! rescue nil
    Post.__elasticsearch__.create_index!

    @category_with_the_biggest_title  = FactoryGirl.create(:category, title: 'AAA Category with the biggest title')
    @category_with_the_smallest_title = FactoryGirl.create(:category, title: 'ЯЯЯ Category with the smallest title')

    @simple_category = FactoryGirl.create(:category, title: 'Simple category')

    @post              = FactoryGirl.create(:post, title: 'Miracle', category: @simple_category, tag_list: 'First, Second')
    @unpublished_post  = FactoryGirl.create(:post, published: false)

    @first_tag = @post.tags.first
    @second_tag = @post.tags.last

    @post_with_the_biggest_title           = FactoryGirl.create(:post, title: 'AAA The biggest title', category: @simple_category)
    @post_with_the_biggest_category_title  = FactoryGirl.create(:post, category: @category_with_the_biggest_title)
    @post_with_the_smallest_title          = FactoryGirl.create(:post, title: 'Яхт клуб The smallest title', category: @simple_category)
    @post_with_the_smallest_category_title = FactoryGirl.create(:post, category: @category_with_the_smallest_title)
    @post_which_is_market_first_tag        = FactoryGirl.create(:post, title: 'Simple post', category: @simple_category, tag_list: @first_tag.name)

    refresh_elasticsearch_cluster
  end

  describe 'has method get_records' do
    context 'which will return @post if' do
      it 'gives product part type title = Miracle' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: 'Miracle'})
        expect(@searcher.get_records.first).to eq(@post)
      end

      it 'gives product part type title = Miracle' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: 'Miracle'})
        expect(@searcher.get_records.first).to eq(@post)
      end

      it 'gives not full product part type title (racl)' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: 'racl'})
        results = @searcher.get_records
        expect(results.any?{|r| r.eql?(@post)}).to eq(true)
      end
    end

    ###############################
    ####### rebuild index TODO ####
    ###############################
    it 'will find all posts if give blank string' do
      @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''})
      results = @searcher.get_records
      expect(results.total).to eq(Post.published.count) #except unpublished
    end

    it 'will find all posts which are marked First tag' do
      @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: '', tag_list: [@first_tag.name]})
      results = @searcher.get_records
      expect(results.total).to eq(2)
      expect(results.any?{|r| r.eql?(@post)}).to eq(true)
      expect(results.any?{|r| r.eql?(@post_which_is_market_first_tag)}).to eq(true)
    end

    it 'will return just @post if filter by first_tag and second_tag' do
      @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: '', tag_list: [@first_tag.name, @second_tag.name]})
      results = @searcher.get_records
      expect(results.total).to eq(1)
      expect(results.any?{|r| r.eql?(@post)}).to eq(true)
    end

    it 'will not find unpublished post' do
      @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''})
      results = @searcher.get_records
      expect(results.any?{|r| r.eql?(@unpublished_post)}).to eq(false)
    end

    context 'which will not return @post if' do
      it 'gives product part type title not equal Miracle' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: 'Shit'})
        results = @searcher.get_records
        expect(results.any?{|r| r.eql?(@post)}).to eq(false)
      end
    end

    context 'can sort records by' do

      it "title.sort with asc direction" do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''}, sort: { 'title.sort' => :asc })
      
        results = @searcher.get_records
        expect(results.first).to eq(@post_with_the_biggest_title)
      end

      it "title.sort with desc direction" do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''}, sort: { "title.sort" => :desc })
      
        results = @searcher.get_records
        expect(results.first).to eq(@post_with_the_smallest_title)
      end

      it 'category.title.sort with asc direction' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''}, sort: { 'category.title.sort' => :asc })
      
        results = @searcher.get_records
        expect(results.first.category).to eq(@category_with_the_biggest_title)
        expect(results.first).to eq(@post_with_the_biggest_category_title)
      end

      it 'category.title.sort with desc direction' do
        @searcher = VAlexL::RubyDevTest::Searcher::PostSearcher.new({q: ''}, sort: { 'category.title.sort' => :desc })
      
        results = @searcher.get_records
        expect(results.first.category).to eq(@category_with_the_smallest_title)
        expect(results.first).to eq(@post_with_the_smallest_category_title)
      end

    end

  end

end

