class AddAdoptedSince < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :adopted_since, :datetime
  end
end
