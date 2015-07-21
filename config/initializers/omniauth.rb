require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_SET_PREP_ID"], ENV["SPOTIFY_SET_PREP_SECRET"], scope: 'user-read-email playlist-modify-private'
end
