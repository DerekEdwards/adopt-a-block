class AddUserToBlocks < ActiveRecord::Migration[5.1]
  def change
    add_reference :blocks, :user, index: true, foreign_key: true
  end
end
