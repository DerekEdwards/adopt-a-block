class Cleaning < ApplicationRecord

  belongs_to :block

  mount_uploader :photo, PhotoUploader

  def days_since_cleaned
    days = (Time.now.to_date - time.to_date).to_i
    if days == 0
      return "cleaned today"
    elsif days == 1
      return "cleaned yesterday"
    else
      return "cleaned #{days} days ago"
    end
  end
end
