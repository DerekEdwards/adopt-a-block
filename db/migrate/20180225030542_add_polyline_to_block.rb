class AddPolylineToBlock < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :polyline, :text
  end
end
