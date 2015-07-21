require "#{Rails.root}/lib/setlistfm"

class SetlistProvider

  def self.performed_songs(artist_name, date)
    setlists = get(artist_name, date)
    songs = {}
    setlists.each do |setlist|
      setlist.sets.each do |set|
        set.songs.each do |song|
          if !song.name.blank?
            if songs[song.name] == nil
              songs[song.name] = PlaylistSong.new(
                name: song.name,
                performance_count: 1,
                last_performed: setlist.event_date,
              )
            else
              songs[song.name].performance_count = songs[song.name].performance_count + 1
            end
          end
        end
      end
    end
    songs.values
  end

  def self.get(artist, date)
    setlists = []
    current_page = 1
    page_results = get_page(artist, current_page)
    while (page_results != nil)
      page_results.each do |setlist|
        parsed = SetlistParser.parse(setlist)
        if !parsed.sets.nil? && parsed.event_date != nil
          if parsed.event_date > date
            (setlists << parsed).flatten!
          else
            return setlists
          end
        else
          (setlists << parsed).flatten! if !parsed.empty?
        end
      end
      current_page = current_page + 1
      page_results = get_page(artist, current_page)
    end
    return setlists
  end

  private

  def self.get_page(artist, page)
    url = URI.parse(Fm::SETLIST_SEARCH_URL + "?artistName=#{URI::encode(artist)}&p=#{page}")
    request = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    res = http.start do |ht|
        ht.request(request)
    end
    begin
      json = JSON.parse(res.body)
      return json["setlists"]["setlist"]
    rescue
      return nil
    end
  end

end
