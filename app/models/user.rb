class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blocks
  has_many :events
  has_and_belongs_to_many :neighborhoods

  ## Follow neighborhood
  def follow neighborhood
    neighborhood.add_follower self 
  end

  ## Unfollow Neighborhood
  def unfollow neighborhood
    neighborhood.remove_follower self
  end

  ## Does this user follow a neighborhood?
  def follows? neighborhood
    neighborhood.in? neighborhoods
  end

end
