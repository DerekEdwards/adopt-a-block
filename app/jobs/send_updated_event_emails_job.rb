class SendUpdatedEventEmailsJob < ApplicationJob
  queue_as :default

  def perform event
    event.neighborhood.mailing_list.each do |user|
      UserMailer.updated_event_email(event, user).deliver!
    end
  end
end


