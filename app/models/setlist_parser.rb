class SetlistParser

  def self.parse(input)
    if input != nil
      fm_setlist = Fm::Setlist::Api::Model::Setlist.from_json(input)
      if fm_setlist.sets != nil
        setlist = Setlist.new(event_date: fm_setlist.eventDate)
        fm_setlist.sets.each do |set|
          if !set.songs.empty? && set.songs.all? {|song| song != nil}
            setlist.sets << set
          end
        end
      end
    end
    setlist
  end

end
