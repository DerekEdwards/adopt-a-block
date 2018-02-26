class AddStufftoCleanings < ActiveRecord::Migration[5.1]
  def change
    add_reference :cleanings, :block, index: true, foreign_key: true
    add_column :cleanings, :time, :datetime
    add_column :cleanings, :note, :text
  end
end
