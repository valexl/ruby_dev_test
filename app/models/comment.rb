class Comment < ActiveRecord::Base
  PENDING = 'pending'
  ACCEPT  = 'accept'
  DECLINE = 'decline'

  STATUSES = [PENDING, ACCEPT, DECLINE]
  scope :pending,   -> { where(status: PENDING) }
  scope :accepting, -> { where(status: ACCEPT) }
  scope :declining, -> { where(status: DECLINE) }

  belongs_to :post
  belongs_to :user

  validates :post, presence: true
  validates :status, inclusion: STATUSES

  STATUSES.each do |status|
    define_method "#{status}!" do
      self.status = status and save
    end
    
    define_method "is_#{status}?" do
      self.status == status
    end
  end

end
