class AddAdoptionExpirationToBlock < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :adoption_expiration, :datetime
  end
end
