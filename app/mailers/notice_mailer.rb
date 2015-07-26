class NoticeMailer < ActionMailer::Base
  default from: "notification@alexey-volobuev.info"

  def new_user(user_id)
    @user    = User.find(user_id)
    email    = @user.email 

    mail(to: email, subject: 'Successful registration')
  end
end
