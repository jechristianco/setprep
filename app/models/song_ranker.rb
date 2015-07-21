class SongRanker

  def self.rank(songs)
    max_popularity = get_max_popularity(songs)
    max_performance_count = get_max_performance_count(songs)
    songs.each do |song|
      if song.popularity == nil
        perf = song.performance_count.to_f / max_performance_count.to_f
        song.score = perf * 100
      else
        pop = song.popularity.to_f / max_popularity.to_f
        perf = song.performance_count.to_f / max_performance_count.to_f
        song.score = (pop + perf) * 50
      end
    end
  end

  private

  def self.get_max_popularity(songs)
    max = 0
    songs.each do |song|
      if song.popularity != nil && song.popularity > max
        max = song.popularity
      end
    end
    return max
  end

  def self.get_max_performance_count(songs)
    max = 0
    songs.each do |song|
      if song.performance_count > max
        max = song.performance_count
      end
    end
    return max
  end

end
