class SwitchKeyFromPlaylistToSearch < ActiveRecord::Migration
  def change
    remove_column :playlists, :search_id, :integer
    add_column :searches, :playlist_id, :integer
  end
end
