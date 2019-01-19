class AddMessageToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :message, :text
  end
end
