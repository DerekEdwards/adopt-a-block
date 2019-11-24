class AddUserAndNeighborhoodToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :user, index: true
    add_reference :events, :neighborhood, index: true
  end
end
