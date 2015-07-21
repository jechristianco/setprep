class Search < ActiveRecord::Base

  belongs_to :playlist

  def execute
    playlist = get_recent_playlist
    if playlist != nil
      update(playlist: playlist)
    else
      delay.build_new_playlist
    end
  end


  def get_recent_playlist
    Search.where(query: query).where('created_at >= ?', 1.day.ago).each do |recent_search|
      if !recent_search.playlist.nil? && recent_search.playlist.created_at >= 1.day.ago
        return recent_search.playlist
      end
    end
    return nil
  end

  def build_new_playlist
    @playlist = Playlist.create(artist_name: query)
    @playlist.build
    update(playlist: @playlist)
  end

end
