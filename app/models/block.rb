class Block < ApplicationRecord

  belongs_to :neighborhood
  has_many :cleanings

  serialize :polyline

  def clean note=nil, time=Time.now
    Cleaning.create(block: self, time: time, note: note)
  end


  def last_cleaning
     cleanings.order('time').last
  end

  def last_cleaned
    lc = last_cleaning
    lc.nil? ? nil : lc.time
  end

  def days_since_cleaned
    lc = last_cleaned
    if lc.nil?
      return "Never cleaned."
    end
    days = (Time.now.to_date - lc.to_date).to_i
    if days == 0
      return "Cleaned today"
    elsif days == 1
      return "Cleaned yesterday"
    else
      return "Last cleaned #{days} days ago"
    end
  end


  def color
    lc = last_cleaned
    if lc.nil?
      return "#000000"
    elsif lc > (Time.now - 8.days)
      return "#00CC00"
    elsif lc > (Time.now - 15.days)
      return "#FFFF00"
    elsif lc > (Time.now - 22.days)
      return "#FF9900"
    else
      return "#FF0000"
    end
  end

  def content
    "<strong>#{name}</strong><br>#{description}<br>#{days_since_cleaned}"
  end
end
