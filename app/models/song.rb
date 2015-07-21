class Song

  attr_accessor :artist, :name, :performance_count, :popularity, :score, :last_performed

  def initialize(args={})
    @artist = args[:artist]
    @name = args[:name]
    @performance_count = args[:performance_count]
    @popularity = get_popularity
    @last_performed = args[:last_performed]
    @artist = Artist.new(name: args[:artist_name]) if !args[:artist_name].blank?
  end

end
