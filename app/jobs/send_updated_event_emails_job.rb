class SendUpdatedEventEmailsJob < ApplicationJob
  queue_as :default

  def perform event
    UserMailer.updated_event_email(event).deliver!
  end
end


