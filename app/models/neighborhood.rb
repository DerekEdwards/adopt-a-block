class Neighborhood < ApplicationRecord
  
  has_many :blocks 
  has_many :cleanings, through: :blocks 
  has_many :events
  has_and_belongs_to_many :users


  mount_uploader :photo, PhotoUploader

  scope :published, ->{ where(published: true) }

  include Chartable

  # Build a Map hash for Google Maps
  def map_hash
    block_array = []
    self.blocks.each do |block|
      block_array << {polyline: block.polyline, color: block.hex_color, content: block.content, center: [block.center[:lat], block.center[:lng]], adopted: block.adopted? }
    end
    block_array
  end

  def center
    return {lat: lat.to_f, lng: lng.to_f}
  end

  # Get a list of users relevant to the blocks.
  # Currently, this is only people who have actively adopted blocks
  # Later, this should be people who have subscribed to block updates.
  # Also, don't include people who have turned off block notifications
  def mailing_list
    my_adopters = blocks.joins(:user).where.not(user_id: nil).where('users.subscribed_to_neighborhood_updates = ?', true).map{ |x| x.user}
    my_followers = followers.where(subscribed_to_neighborhood_updates: true).to_a
    (my_adopters + my_followers).uniq
  end

  ## Add Follower
  def add_follower user
    unless user.in? users 
      users << user 
    end
  end

  ## Remove Follower
  def remove_follower user 
    users.delete(user)
  end

  ## Synonym for users
  def followers
    users
  end  
end
