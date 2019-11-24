class Event < ApplicationRecord
  belongs_to :user
  belongs_to :neighborhood

   scope :future, ->{ where('event_date >= ?', Time.now) }
   scope :past, ->{ where('event_date < ?', Time.now) }

end
