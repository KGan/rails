class AddUserIdToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :user_id, :integer, null:false
    add_column :albums, :user_id, :integer, null:false
  end
end
