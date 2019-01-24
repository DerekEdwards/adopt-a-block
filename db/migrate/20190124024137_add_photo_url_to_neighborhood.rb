class AddPhotoUrlToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :photo, :string
  end
end
