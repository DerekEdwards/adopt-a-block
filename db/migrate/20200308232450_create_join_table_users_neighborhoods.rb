class CreateJoinTableUsersNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :neighborhoods do |t|
      # t.index [:user_id, :neighborhood_id]
      # t.index [:neighborhood_id, :user_id]
    end
  end
end
