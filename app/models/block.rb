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

  def days_adopted
    if self.adopted_since and self.end_of_adoption
      return ((end_of_adoption - adopted_since)/86400).to_i
    else
      return nil
    end
  end

  def adopt user, alert_admin=true
    self.user = user
    self.adopted_since = Time.now
    self.adoption_expiration = Time.now + 3.months
    result = self.save 

    # Let admins know that a block has been adoapted
    # Unless the adopter is also the admin
    if alert_admin
      User.admin.each do |admin|
        unless user == admin 
          UserMailer.new_adoption_alert(self, admin).deliver!
        end
      end
    end

    result 
  end

  def unadopt send_email=false
    # Let the adopter know that their block as been automatically unadopted
    if send_email 
      UserMailer.unadopt_email(self).deliver!
    end
    self.user = nil
    self.adopted_since = nil
    self.adoption_expiration = nil
    self.save
  end

  def adopted?
    return !(self.user_id == nil)
  end

  def adopted_description
    if user and adoption_expiration
      return "This block is adopted by #{user.name} until #{self.end_of_adoption.strftime('%b %e')}."
    elsif user
      return "This block is adopted by #{user.name}."
    end
  end

  def end_of_adoption
    if adoption_expiration 
      if last_cleaned
        return [self.adoption_expiration, last_cleaned + 3.months].max
      else
        return self.adoption_expiration
      end
    else
      return nil
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
    "<h2><a href=#{Rails.application.routes.url_helpers.block_path(self)}>#{name}</a></h2>
     <a href=#{Rails.application.routes.url_helpers.block_path(self)}>View More</a>
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

  def cleanings_past_x_days days
    self.cleanings.where('time > ?', Time.now - days.days - 1).count
  end
end
