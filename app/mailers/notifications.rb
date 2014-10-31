class Notifications < ActionMailer::Base
  default from: "from@example.com"

  def notify(user)
    @user = user
    @greeting = @user.message

    mail to: @user.email
  end
end
