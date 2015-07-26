class Workers::NoticeUserAboutCreating < Struct.new(:user_id)
  def perform
    NoticeMailer.new_user(user_id).deliver!
  end
end



