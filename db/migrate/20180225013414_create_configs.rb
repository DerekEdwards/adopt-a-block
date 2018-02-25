class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.string :key, null: false, unique: true
      t.text :value
      t.timestamps
    end
  end
end
