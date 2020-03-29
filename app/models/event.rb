class Event < ApplicationRecord
  belongs_to :user
  belongs_to :neighborhood

  scope :future, ->{ where('event_date >= ?', Time.now) }
  scope :past, ->{ where('event_date < ?', Time.now) }

  def duration
    self.start_time.in_time_zone.strftime("%I:%M %p") + " to " + self.end_time.in_time_zone.strftime("%I:%M %p")
  end

end
