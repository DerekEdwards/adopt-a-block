class AddCanceledToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :canceled, :boolean, null: false, default: false
  end
end
