class AddBlockToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_reference :blocks, :neighborhood, index: true, foreign_key: true
  end
end
