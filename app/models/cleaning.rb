class Cleaning < ApplicationRecord

  belongs_to :block

  mount_uploader :before_photo, PhotoUploader
  mount_uploader :after_photo, PhotoUploader

  def days_since_cleaned
    days = (Time.now.in_time_zone.to_date - time.in_time_zone.to_date).to_i
    if days == 0
      return "cleaned today"
    elsif days == 1
      return "cleaned yesterday"
    else
      return "cleaned #{days} days ago"
    end
  end
end
