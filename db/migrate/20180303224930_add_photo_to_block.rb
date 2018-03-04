class AddPhotoToBlock < ActiveRecord::Migration[5.1]
  def change
    add_column :cleanings, :before_photo, :string
    add_column :cleanings, :after_photo, :string
  end
end
