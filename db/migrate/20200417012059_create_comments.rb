class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :message
      t.references :user
      t.references :cleaning
      t.timestamps
    end
  end
end
