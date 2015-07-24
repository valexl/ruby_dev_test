class Post < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :category
  has_many   :comments

  validates :title, presence: true
  validates :category, presence: true, :if => :published?

  def publish!
    self.published = true and save
  end

  def unpublish!
    self.published = false
    save
  end
end
