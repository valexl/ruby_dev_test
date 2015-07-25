class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  after_create :try_make_admin!

  private
    def try_make_admin!
      self.admin = true and save if User.count == 1 #only just created user (current_user)
      true
    end

end
