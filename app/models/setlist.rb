class Setlist

  attr_accessor :event_date, :sets

  def initialize(args={})
    @sets = args[:sets] || []
    @event_date = args[:event_date]
  end

end
