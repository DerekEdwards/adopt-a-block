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
    @event.neighborhood.mailing_list.each do |user|
      @user = user
      mail(to: user.email, subject: event.name)
    end
  end

  def updated_event_email event
    @event = event

    subject = "Update on #{event.name}"
    if @event.canceled
      subject = "CANCELED #{event.name}"
    end

    @event.neighborhood.mailing_list.each do |user|
      @user = user
      mail(to: user.email, subject: subject)
    end

  end

end
