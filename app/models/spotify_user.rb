class SpotifyUser < ActiveRecord::Base
  serialize :spotify_hash, Hash
end
