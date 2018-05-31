class Block < ApplicationRecord

  belongs_to :neighborhood
  has_many :cleanings
  belongs_to :user, optional: true 

  serialize :polyline

  scope :adopted, ->{ where.not(user_id: nil) }
  scope :orphaned, ->{ where(user_id: nil) }
  scope :order_by_name, ->{ order(name: :asc) }

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

  def adopted_description
    if user
      return "This block is adopted by #{user.name}"
    else
      return "Contact <a href='mailto:dedwards8@gmail.com'>Derek Edwards</a> to adopt this block."
    end
  end

  def hex_color
    lc = last_cleaned
    if lc.nil?
      return "#000000"
    elsif lc > (Time.now - 11.days)
      return "#00CC00"
    elsif lc > (Time.now - 21.days)
      return "#FFFF00"
    elsif lc > (Time.now - 31.days)
      return "#FF9900"
    elsif lc > (Time.now - 91.days)
      return "#FF0000"
    else
      return "#000000"
    end
  end

  def color
    lc = last_cleaned
    if lc.nil?
      return "black"
    elsif lc > (Time.now - 11.days)
      return "green"
    elsif lc > (Time.now - 21.days)
      return "yellow"
    elsif lc > (Time.now - 31.days)
      return "orange"
    elsif lc > (Time.now - 91.days)
      return "red"
    else
      return "black"
    end
  end

  def content
    "<h2><a href=#{Rails.application.routes.url_helpers.admin_block_path(self)}>#{name}</a></h2>
     <a href=#{Rails.application.routes.url_helpers.admin_block_path(self)}>View More</a>
     <br>#{description}
     <br>#{days_since_cleaned}
     <br>#{adopted_description}"
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
