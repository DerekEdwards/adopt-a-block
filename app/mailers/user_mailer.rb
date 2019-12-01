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
    mail(to: block.user.email, subject: 'Your block has been automatically un-adopted.')
  end


  def new_event_email event
    @event = event
    mail(to: event.neighborhood.mailing_list, subject: event.name)
  end

  def updated_event_email event
    @event = event
    mail(to: event.neighborhood.mailing_list, subject: "Update on #{event.name}")
  end

end
