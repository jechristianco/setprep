class AddArtistNameToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :artist_name, :string
  end
end
