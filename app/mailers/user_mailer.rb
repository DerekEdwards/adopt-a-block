class UserMailer < ApplicationMailer

  def reminder_email user, blocks
    @user = user
    @blocks = blocks
    mail(to: @user.email, subject: 'Cleaning Reminder')
  end

end
