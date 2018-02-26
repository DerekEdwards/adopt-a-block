class CreateCleanings < ActiveRecord::Migration[5.1]
  def change
    create_table :cleanings do |t|

      t.timestamps
    end
  end
end
