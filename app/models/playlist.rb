class Playlist < ActiveRecord::Base

  has_many :searches

  has_many :songs, class_name: "PlaylistSong"

  def build
    performed_songs = SetlistProvider.performed_songs(artist_name, 6.months.ago)
    performed_songs = SetlistProvider.performed_songs(artist_name, 12.months.ago) if total_performances(select_songs(performed_songs)) < 20
    performed_songs = SetlistProvider.performed_songs(artist_name, 200.years.ago) if total_performances(select_songs(performed_songs)) < 20
    playlist_songs = select_songs(performed_songs)
    playlist_songs.each do |song|
      song.playlist = self
      song.popularity = Spotify.get_popularity(song)
    end
    SongRanker.rank(playlist_songs)
    ActiveRecord::Base.transaction do
      playlist_songs.each do |song|
        song.save
      end
    end
    update(warning: "We unfortunately could not find this artist. Please try again") if songs.empty?
  end

  private

  def total_performances(songs)
    count = 0
    songs.each do |song|
      count += song.performance_count
    end
    count
  end

  def select_songs(songs)
    songs.sort {|x,y| x.performance_count <=> y.performance_count} .reverse[0..20]
  end

end
