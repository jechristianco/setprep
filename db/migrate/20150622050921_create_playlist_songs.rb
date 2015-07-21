class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.integer :playlist_id
      t.float :score
      t.integer :performance_count
      t.float :popularity
      t.date :last_performed
      t.string :name
      t.string :artist_name

      t.timestamps
    end
  end
end
