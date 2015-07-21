class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :search_id

      t.timestamps
    end
  end
end
