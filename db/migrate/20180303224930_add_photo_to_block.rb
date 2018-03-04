class AddPhotoToBlock < ActiveRecord::Migration[5.1]
  def change
    add_column :cleanings, :photo, :string
  end
end
