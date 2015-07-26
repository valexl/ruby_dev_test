class VAlexL::RubyDevTest::FormObject::Commentation
  include ActiveModel::Model
  include ActiveModel::Validations

  delegate :post_id,  :user_id,  :content,  to: :comment
  delegate :post_id=, :user_id=, :content=, to: :comment

  attr_accessor :post_id, :user_id, :content, :comment, :captcha

  validates :content, :post_id, presence: true
  validate :check_user

  def save
    return false unless valid?
    comment = Comment.new user_id: user_id, post_id: post_id, content: content, status: Comment::PENDING
    comment.save
  end

  private
    def check_user
      return true if user_id.present?
      return true if correct_captcha?
      errors.add(:comment, :incorect_captcha)
    end

    def correct_captcha?
      captcha.to_s == 'one' || captcha.to_s == '1'
    end
end
