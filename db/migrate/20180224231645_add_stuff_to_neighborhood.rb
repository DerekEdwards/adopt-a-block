class AddStuffToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :name, :string
    add_column :neighborhoods, :description, :text
  end
end
