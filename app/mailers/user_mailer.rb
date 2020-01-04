class UserMailer < ApplicationMailer

  def reminder_email user, blocks
    @user = user
    @blocks = blocks
    if @user.subscribed_to_reminders
      mail(to: @user.email, subject: 'Block Cleaning Reminder')
    end
  end

  def unadopt_email block
    @block = block
    @days = block.days_adopted
    mail(to: block.user.email, subject: 'Your block has been automatically un-adopted.')
  end


  def new_event_email event, user
    @event = event
    @user = user
    mail(to: user.email, subject: event.name)
  end

  def updated_event_email event, user
    @event = event
    @user = user

    subject = "Update on #{event.name}"
    if @event.canceled
      subject = "CANCELED #{event.name}"
    end

    mail(to: user.email, subject: subject)

  end

end
