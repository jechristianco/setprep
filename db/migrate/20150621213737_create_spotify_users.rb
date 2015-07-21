class CreateSpotifyUsers < ActiveRecord::Migration
  def change
    create_table :spotify_users do |t|
      t.text :spotify_hash
      t.string :spotify_id

      t.timestamps
    end
  end
end
