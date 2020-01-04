class AddSubscribeToEventsEmailsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subscribed_to_neighborhood_updates, :boolean, null: false, default: true
  end
end