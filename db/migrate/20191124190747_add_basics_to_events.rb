class AddBasicsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :name, :string, null: false
    add_column :events, :description, :text
    add_column :events, :location_description, :text, null: false
    add_column :events, :event_date, :date, null: false
    add_column :events, :start_time, :time, null: false
    add_column :events, :end_time, :time, null: false
    add_column :events, :photo_url, :string
  end
end
