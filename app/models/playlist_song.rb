class PlaylistSong < ActiveRecord::Base
  belongs_to :playlist

  def artist_name
    playlist.artist_name
  end

end
