class Category < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes

  validates :title, presence: true
end
