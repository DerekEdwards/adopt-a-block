class AddPublishedToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :published, :boolean, null: false, default: false
  end
end
