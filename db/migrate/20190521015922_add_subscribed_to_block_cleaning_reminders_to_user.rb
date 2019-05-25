class AddSubscribedToBlockCleaningRemindersToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subscribed_to_reminders, :boolean, default: true
  end
end
