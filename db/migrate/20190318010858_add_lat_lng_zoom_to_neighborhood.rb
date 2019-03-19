class AddLatLngZoomToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :lat, :decimal
    add_column :neighborhoods, :lng, :decimal
    add_column :neighborhoods, :zoom, :integer
  end
end
