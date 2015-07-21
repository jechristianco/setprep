class CreateSpotifyPlaylists < ActiveRecord::Migration
  def change
    create_table :spotify_playlists do |t|
      t.integer :playlist_id
      t.string :name
      t.integer :spotify_user_id

      t.timestamps
    end
  end
end
