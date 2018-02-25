class Block < ApplicationRecord

  belongs_to :neighborhood
  has_many :cleanings

  serialize :polyline

  def clean note=nil, time=Time.now
    Cleaning.create(block: self, time: time, note: note)
  end


  def last_cleaning
     self.cleanings.order('time').last
  end

  def last_cleaned
    lc = last_cleaning
    lc.nil? ? nil : lc.time
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
end
