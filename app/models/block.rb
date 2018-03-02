class Block < ApplicationRecord

  belongs_to :neighborhood
  has_many :cleanings
  belongs_to :user

  serialize :polyline

  scope :adopted, ->{ where.not(user_id: nil) }
  scope :orphaned, ->{ where(user_id: nil) }

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
    lc = last_cleaning
    if lc.nil?
      return "Never cleaned."
    end
    return lc.days_since_cleaned
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
    puts 
    "<strong><a href=#{Rails.application.routes.url_helpers.admin_block_path(self)} target='_blank'>#{name}</a></strong>
     <br>#{description}
     <br>#{days_since_cleaned}"
  end

  def center
    if polyline.blank?
      return {lat: 0, lng: 0}
    end

    lat = 0.0
    lng = 0.0

    polyline.each do |point|
      lat += point[:lat].to_f
      lng += point[:lng].to_f
    end

    return {lat: lat/polyline.count, lng: lng/polyline.count}
  end

end
