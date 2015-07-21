class SwitchWarningFromSearchToPlaylist < ActiveRecord::Migration
  def change
    remove_column :searches, :warning, :string
    add_column :playlists, :warning, :string
  end
end
