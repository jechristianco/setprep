class SearchSuggestion

  def self.terms_for(prefix)
    $redis.zrevrange "search-suggestions:#{prefix.downcase}", 0, 9
  end

  def self.index_artists
    Artist.each_from_file do |artist|
      new_word_indices = [0]
      (0..(artist.name.length)).each do |i|
        char = artist.name[i]
        new_word_indices << i + 1 if char == ' '
        break if char == '('
      end
      new_word_indices.each { |i| index_term(artist, i) }
    end
  end

  def self.index_term(artist, index)
    term = artist.name[index, artist.name.length]
    1.upto(term.length) do |n|
      prefix = term[0, n]
      $redis.zincrby "search-suggestions:#{prefix.downcase}", 1, artist.full_description
    end
  end

end
