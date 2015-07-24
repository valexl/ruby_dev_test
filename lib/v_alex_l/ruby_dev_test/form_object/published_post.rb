class VAlexL::RubyDevTest::FormObject::PublishedPost
  include ActiveModel::Model
  include ActiveModel::Validations

  delegate :category_id,  :tag_list,  to: :post
  delegate :category_id=, :tag_list=, to: :post

  attr_accessor :post

  validates :category_id, :tag_list, presence: true

  def apply!
    return false unless valid?
    post.publish!
  end
end
