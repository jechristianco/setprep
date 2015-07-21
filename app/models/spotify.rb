class Spotify

  def self.create_playlist(auth, playlist_id)
    spotify_user = RSpotify::User.new(auth)
    playlist = Playlist.find(playlist_id)
    user = SpotifyUser.find_or_create_by(spotify_id: spotify_user.id)
    user.update(spotify_hash: spotify_user.to_hash) if user.spotify_hash.empty?
    name = "Set Prep: " + playlist.artist_name + " - " + Date.today.strftime("%m/%d/%Y")
    tracks = []
    playlist.songs.order(:score).reverse.each do |song|
      track = get_track(song)
      tracks << track if track != nil
    end
    if (!tracks.empty?)
      spotify_playlist = spotify_user.create_playlist!(name, public: false)
      spotify_playlist.add_tracks!(tracks)
      SpotifyPlaylist.create(name: name, spotify_user: user, playlist: playlist)
    end
  end

  def self.get_popularity(song)
    track = get_track(song)
    if track != nil
      return track.popularity
    else
      return nil
    end
  end

  private

  def self.get_track(song)
    name = song.name
    artist = song.artist_name
    if !name.blank? && !artist.blank?
      tracks = RSpotify::Track.search(name + " " + artist)
      tracks.each do |track|
        track.artists.each do |spotify_artist|
          return track if spotify_artist.name.downcase.include? artist.downcase
        end
      end
    end
    return nil
  end

end
