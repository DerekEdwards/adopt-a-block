class Block < ApplicationRecord
  belongs_to :neighborhood

  serialize :polyline
  
end
