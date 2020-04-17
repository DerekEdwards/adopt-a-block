class Comment < ApplicationRecord

  belongs_to :cleaning
  belongs_to :user

end
