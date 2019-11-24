class Neighborhood < ApplicationRecord
  
  has_many :blocks 
  has_many :cleanings, through: :blocks 
  has_many :events

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
end
