class DropArtistNameFromPlaylistSong < ActiveRecord::Migration
  def change
    remove_column :playlist_songs, :artist_name, :string
  end
end
