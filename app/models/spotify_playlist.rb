class SpotifyPlaylist < ActiveRecord::Base

  belongs_to :spotify_user
  belongs_to :playlist

end
