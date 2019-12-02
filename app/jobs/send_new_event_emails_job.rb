class SendNewEventEmailsJob < ApplicationJob
  queue_as :default

  def perform event
    UserMailer.new_event_email(event).deliver!
  end
end


