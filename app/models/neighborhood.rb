class Neighborhood < ApplicationRecord
  
  has_many :blocks 
  has_many :cleanings, through: :blocks 

  mount_uploader :photo, PhotoUploader

  # Build a Map hash for Google Maps
  def map_hash
    block_array = []
    self.blocks.each do |block|
      block_array << {polyline: block.polyline, color: block.hex_color, content: block.content}
    end
    block_array
  end
end
