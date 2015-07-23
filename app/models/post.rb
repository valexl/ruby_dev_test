class Post < ActiveRecord::Base
  
  belongs_to :category
  has_many   :comments

  validates :title, presence: true
  validates :category, presence: true, :if => :published?
end
