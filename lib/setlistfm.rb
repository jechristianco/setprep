require 'json'

# adding necessary json serialization methods to standard classes.
class Object
  def to_jaxb_json_hash
    return self
  end
  def self.from_json o
    return o
  end
end

class String
  def self.from_json o
    return o
  end
end

class Boolean
  def self.from_json o
    return o
  end
end

class Numeric
  def self.from_json o
    return o
  end
end

class Time
  #json time is represented as number of milliseconds since epoch
  def to_jaxb_json_hash
    return (to_i * 1000) + (usec / 1000)
  end
  def self.from_json o
    if o.nil?
      return nil
    else
      return Time.at(o / 1000, (o % 1000) * 1000)
    end
  end
end

class Array
  def to_jaxb_json_hash
    a = Array.new
    each { | _item | a.push _item.to_jaxb_json_hash }
    return a
  end
end

class Hash
  def to_jaxb_json_hash
    h = Hash.new
    each { | _key, _value | h[_key.to_jaxb_json_hash] = _value.to_jaxb_json_hash }
    return h
  end
end

module Fm
  SETLIST_SEARCH_URL = "http://api.setlist.fm/rest/0.1/search/setlists.json"
end

module Fm

module Setlist

module Api

module Model

  # This class represents a city where Venues are located. Most of the
  # original city data was taken from <a
  # href="http://geonames.org/">Geonames.org</a>.
  class City

    # unique identifier
    attr_accessor :id
    # the city's name, depending on the language valid values are e.g.
    # &lt;em&gt;&amp;quot;M&amp;uuml;chen&amp;quot;&lt;/em&gt; or &lt;em&gt;Munich&lt;/em&gt;
    attr_accessor :name
    # The name of city's state, e.g. &lt;em&gt;&amp;quot;Bavaria&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;Florida&amp;quot;&lt;/em&gt;
    attr_accessor :state
    # The code of the city's state. For most countries this two-digit
    # numeric code, with which the state can be identified uniquely in
    # the specific Country. The code can also be a String for
    # other cities. Valid examples are &lt;em&gt;&amp;quot;CA&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;02&amp;quot;&lt;/em&gt;
    #
    # which in turn get uniquely identifiable when combined with the
    # state's country:
    #
    # &lt;em&gt;&amp;quot;US.CA&amp;quot;&lt;/em&gt; for California, United States or
    # &lt;em&gt;&amp;quot;DE.02&amp;quot;&lt;/em&gt; for Bavaria, Germany
    #
    # For a complete list of available states (that aren't necessarily
    # used in this database) is available in &lt;a
    # href=&quot;http://download.geonames.org/export/dump/admin1Codes.txt&quot;&gt;a
    # textfile on geonames.org&lt;/a&gt;.
    #
    # Note that this code is only unique combined with the city's
    # Country. The code alone is &lt;strong&gt;not&lt;/strong&gt; unique.
    attr_accessor :stateCode
    # The city's coordinates. Usually the coordinates of the city centre are
    # used.
    attr_accessor :coords
    # The city's country.
    attr_accessor :country

    # the json hash for this City
    def to_jaxb_json_hash
      _h = {}
      _h['id'] = id.to_jaxb_json_hash unless id.nil?
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      _h['state'] = state.to_jaxb_json_hash unless state.nil?
      _h['stateCode'] = stateCode.to_jaxb_json_hash unless stateCode.nil?
      _h['coords'] = coords.to_jaxb_json_hash unless coords.nil?
      _h['country'] = country.to_jaxb_json_hash unless country.nil?
      return _h
    end

    # the json (string form) for this City
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this City with a json hash
    def init_jaxb_json_hash(_o)
      @id = String.from_json(_o['id']) unless _o['id'].nil?
      @name = String.from_json(_o['name']) unless _o['name'].nil?
      @state = String.from_json(_o['state']) unless _o['state'].nil?
      @stateCode = String.from_json(_o['stateCode']) unless _o['stateCode'].nil?
      @coords = Fm::Setlist::Api::Model::Coords.from_json(_o['coords']) unless _o['coords'].nil?
      @country = Fm::Setlist::Api::Model::Country.from_json(_o['country']) unless _o['country'].nil?
    end

    # constructs a City from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # Coordinates of a point on the globe. Mostly used for Cities.
  class Coords

    # The longitude part of the coordinates.
    attr_accessor :longitude
    # The latitude part of the coordinates.
    attr_accessor :latitude

    # the json hash for this Coords
    def to_jaxb_json_hash
      _h = {}
      _h['long'] = longitude.to_jaxb_json_hash unless longitude.nil?
      _h['lat'] = latitude.to_jaxb_json_hash unless latitude.nil?
      return _h
    end

    # the json (string form) for this Coords
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Coords with a json hash
    def init_jaxb_json_hash(_o)
      @longitude = Float.from_json(_o['long']) unless _o['long'].nil?
      @latitude = Float.from_json(_o['lat']) unless _o['lat'].nil?
    end

    # constructs a Coords from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # This class represents a country on earth.
  class Country

    # The country's name. Can be a localized name - e.g.
    # &lt;em&gt;&amp;quot;Austria&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;&amp;Ouml;sterreich&amp;quot;&lt;/em&gt; for Austria if the German
    # name was requested.
    attr_accessor :name
    # The country's &lt;a
    # href=&quot;http://www.iso.org/iso/english_country_names_and_code_elements&quot;
    # &gt;ISO code&lt;/a&gt;. E.g. &lt;em&gt;&amp;quot;ie&amp;quot;&lt;/em&gt; for Ireland
    attr_accessor :code

    # the json hash for this Country
    def to_jaxb_json_hash
      _h = {}
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      _h['code'] = code.to_jaxb_json_hash unless code.nil?
      return _h
    end

    # the json (string form) for this Country
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Country with a json hash
    def init_jaxb_json_hash(_o)
      @name = String.from_json(_o['name']) unless _o['name'].nil?
      @code = String.from_json(_o['code']) unless _o['code'].nil?
    end

    # constructs a Country from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A setlist consists of different (at least one) sets. Sets can either be sets
  # as defined in the <a href="http://www.setlist.fm/guidelines">Guidelines</a>
  # or encores.
  class Set

    # if the set is an encore, this is the number of the encore,
    # starting with 1 for the first encore, 2 for the second and so on.
    attr_accessor :encore
    # the description/name of the set. E.g.
    # &lt;em&gt;&amp;quot;Acoustic set&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;Paul McCartney solo&amp;quot;&lt;/em&gt;
    attr_accessor :name
    # this set's songs
    attr_accessor :songs

    # the json hash for this Set
    def to_jaxb_json_hash
      _h = {}
      _h['encore'] = encore.to_jaxb_json_hash unless encore.nil?
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      if !songs.nil?
        _ha = Array.new
        songs.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['song'] = _ha
      end
      return _h
    end

    # the json (string form) for this Set
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Set with a json hash
    def init_jaxb_json_hash(_o)
      @encore = Fixnum.from_json(_o['encore']) unless _o['encore'].nil?
      @name = String.from_json(_o['name']) unless _o['name'].nil?
      if !_o['song'].nil?
        @songs = Array.new
        _oa = _o['song']
        if _oa.kind_of? Array
          _oa.each { | _item | @songs.push Fm::Setlist::Api::Model::Song.from_json(_item) }
        elsif _oa.kind_of? Hash
          @songs.push Fm::Setlist::Api::Model::Song.from_json(_oa)
        end
      end
    end

    # constructs a Set from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # Setlists, that's what it's all about. So if you're trying to use this API
  # without knowing what a setlist is then you're kinda wrong on this page ;-).
  #
  # A setlist can be distinguished from other setlists by its unique id. But as
  # <a href="http://www.setlist.fm/">setlist.fm</a> works the wiki way, there can
  # be different versions of one setlist (each time a user updates a setlist a
  # new version gets created). These different versions have a unique id on its
  # own. So setlists can have the same id although they differ as far as the
  # content is concerned - thus the best way to check if two setlists are the
  # same is to compare their versionIds.
  class Setlist

    # unique identifier
    attr_accessor :id
    # date of the concert in the format &amp;quot;dd-MM-yyyy&amp;quot;
    attr_accessor :eventDate
    # date, time and time zone of the last update to this setlist in
    # the format &amp;quot;yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ&amp;quot;
    attr_accessor :lastUpdated
    # unique identifier of the version
    attr_accessor :versionId
    # the setlist's tour
    attr_accessor :tour
    # the id this event has on &lt;a href=&quot;http://last.fm/&quot;&gt;last.fm&lt;/a&gt;
    attr_accessor :lastFmEventId
    # the setlist's artist
    attr_accessor :artist
    # the setlist's venue
    attr_accessor :venue
    # all sets of this setlist
    attr_accessor :sets
    # additional information on the concert - see the &lt;a
    # href=&quot;http://www.setlist.fm/guidelines&quot;&gt;setlist.fm guidelines&lt;/a&gt;
    # for a complete list of allowed content.
    attr_accessor :info
    # the attribution url to which you have to link to wherever you use
    # data from this setlist in your application
    attr_accessor :url

    # the json hash for this Setlist
    def to_jaxb_json_hash
      _h = {}
      _h['id'] = id.to_jaxb_json_hash unless id.nil?
      _h['eventDate'] = eventDate.to_jaxb_json_hash unless eventDate.nil?
      _h['lastUpdated'] = lastUpdated.to_jaxb_json_hash unless lastUpdated.nil?
      _h['versionId'] = versionId.to_jaxb_json_hash unless versionId.nil?
      _h['tour'] = tour.to_jaxb_json_hash unless tour.nil?
      _h['lastFmEventId'] = lastFmEventId.to_jaxb_json_hash unless lastFmEventId.nil?
      _h['artist'] = artist.to_jaxb_json_hash unless artist.nil?
      _h['venue'] = venue.to_jaxb_json_hash unless venue.nil?
      if !sets.nil?
        _ha = Array.new
        sets.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['sets'] = _ha
      end
      _h['info'] = info.to_jaxb_json_hash unless info.nil?
      _h['url'] = url.to_jaxb_json_hash unless url.nil?
      return _h
    end

    # the json (string form) for this Setlist
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Setlist with a json hash
    def init_jaxb_json_hash(_o)
      @id = String.from_json(_o['id']) unless _o['id'].nil?
      @eventDate = _o['@eventDate'].to_datetime unless _o['@eventDate'].nil?
      @lastUpdated = String.from_json(_o['lastUpdated']) unless _o['lastUpdated'].nil?
      @versionId = String.from_json(_o['versionId']) unless _o['versionId'].nil?
      @tour = String.from_json(_o['tour']) unless _o['tour'].nil?
      @lastFmEventId = Fixnum.from_json(_o['lastFmEventId']) unless _o['lastFmEventId'].nil?
      @artist = Fm::Setlist::Api::Model::Artist.from_json(_o['artist']) unless _o['artist'].nil?
      @venue = Fm::Setlist::Api::Model::Venue.from_json(_o['venue']) unless _o['venue'].nil?
      if !_o['sets'].nil?
        @sets = Array.new
        _oa = _o['sets']
        if !_oa.blank?
          set = _oa['set']
          if !set.blank?
            if set.is_a?(Hash)
              @sets.push(Fm::Setlist::Api::Model::Set.from_json(set))
            else
              set.each do |item|
                @sets.push(Fm::Setlist::Api::Model::Set.from_json(item))
              end
            end
          end
        end
      end
      @info = String.from_json(_o['info']) unless _o['info'].nil?
      @url = String.from_json(_o['url']) unless _o['url'].nil?
    end

    # constructs a Setlist from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # This class represents a user.
  class User

    # (no documentation provided)
    attr_accessor :flickr
    # (no documentation provided)
    attr_accessor :twitter
    # (no documentation provided)
    attr_accessor :website
    # (no documentation provided)
    attr_accessor :userId
    # (no documentation provided)
    attr_accessor :lastFm
    # (no documentation provided)
    attr_accessor :mySpace
    # (no documentation provided)
    attr_accessor :fullname
    # (no documentation provided)
    attr_accessor :about
    # (no documentation provided)
    attr_accessor :url

    # the json hash for this User
    def to_jaxb_json_hash
      _h = {}
      _h['flickr'] = flickr.to_jaxb_json_hash unless flickr.nil?
      _h['twitter'] = twitter.to_jaxb_json_hash unless twitter.nil?
      _h['website'] = website.to_jaxb_json_hash unless website.nil?
      _h['userId'] = userId.to_jaxb_json_hash unless userId.nil?
      _h['lastFm'] = lastFm.to_jaxb_json_hash unless lastFm.nil?
      _h['mySpace'] = mySpace.to_jaxb_json_hash unless mySpace.nil?
      _h['fullname'] = fullname.to_jaxb_json_hash unless fullname.nil?
      _h['about'] = about.to_jaxb_json_hash unless about.nil?
      _h['url'] = url.to_jaxb_json_hash unless url.nil?
      return _h
    end

    # the json (string form) for this User
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this User with a json hash
    def init_jaxb_json_hash(_o)
      @flickr = String.from_json(_o['flickr']) unless _o['flickr'].nil?
      @twitter = String.from_json(_o['twitter']) unless _o['twitter'].nil?
      @website = String.from_json(_o['website']) unless _o['website'].nil?
      @userId = String.from_json(_o['userId']) unless _o['userId'].nil?
      @lastFm = String.from_json(_o['lastFm']) unless _o['lastFm'].nil?
      @mySpace = String.from_json(_o['mySpace']) unless _o['mySpace'].nil?
      @fullname = String.from_json(_o['fullname']) unless _o['fullname'].nil?
      @about = String.from_json(_o['about']) unless _o['about'].nil?
      @url = String.from_json(_o['url']) unless _o['url'].nil?
    end

    # constructs a User from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # Venues are places where concerts take place. They usually consist of a venue
  # name and a city - but there are also some venues that do not have a city
  # attached yet. In such a case, the city simply isn't set and the city and
  # country may (but do not have to) be in the name.
  class Venue

    # unique identifier
    attr_accessor :id
    # the name of the venue, usually without city and country. E.g.
    # &lt;em&gt;&amp;quot;Madison Square Garden&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;Royal Albert Hall&amp;quot;&lt;/em&gt;
    attr_accessor :name
    # the city in which the venue is located
    attr_accessor :city
    # the attribution url
    attr_accessor :url

    # the json hash for this Venue
    def to_jaxb_json_hash
      _h = {}
      _h['id'] = id.to_jaxb_json_hash unless id.nil?
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      _h['city'] = city.to_jaxb_json_hash unless city.nil?
      _h['url'] = url.to_jaxb_json_hash unless url.nil?
      return _h
    end

    # the json (string form) for this Venue
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Venue with a json hash
    def init_jaxb_json_hash(_o)
      @id = String.from_json(_o['id']) unless _o['id'].nil?
      @name = String.from_json(_o['name']) unless _o['name'].nil?
      @city = Fm::Setlist::Api::Model::City.from_json(_o['city']) unless _o['city'].nil?
      @url = String.from_json(_o['url']) unless _o['url'].nil?
    end

    # constructs a Venue from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # This class represents a song that is part of a Set.
  class Song

    # The name of the song. E.g. &lt;em&gt;Yesterday&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;Wish You Were Here&amp;quot;&lt;/em&gt;
    attr_accessor :name
    # A different Artist than the performing one that joined the stage
    # for this song.
    attr_accessor :with
    # The original Artist of this song, if different to the performing
    # artist.
    attr_accessor :cover
    # Special incidents or additional information about the way the song was
    # performed at this specific concert. See the &lt;a
    # href=&quot;http://www.setlist.fm/guidelines&quot;&gt;setlist.fm guidelines&lt;/a&gt; for a
    # complete list of allowed content.
    attr_accessor :info

    # the json hash for this Song
    def to_jaxb_json_hash
      _h = {}
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      _h['with'] = with.to_jaxb_json_hash unless with.nil?
      _h['cover'] = cover.to_jaxb_json_hash unless cover.nil?
      _h['info'] = info.to_jaxb_json_hash unless info.nil?
      return _h
    end

    # the json (string form) for this Song
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Song with a json hash
    def init_jaxb_json_hash(_o)
      @name = String.from_json(_o['@name']) unless _o['@name'].nil?
      @with = Fm::Setlist::Api::Model::Artist.from_json(_o['@with']) unless _o['@with'].nil?
      @cover = Fm::Setlist::Api::Model::Artist.from_json(_o['@cover']) unless _o['@cover'].nil?
      @info = String.from_json(_o['@info']) unless _o['@info'].nil?
    end

    # constructs a Song from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # <p>
  # If a request returns a list of items they're always wrapped into a Result. As
  # there is a maximum amount of items to be returned at once a Result consists
  # of the total amount of items (total), how many items per page you get
  # (itemsPerPage), the current page (page) and the current list of items.
  # </p>
  #
  # <p>
  # E.g. if there are 35 items, itemsPerPage is 10 and the current page is 2,
  # then items 11 to 20 are in the list.
  # </p>
  class Result

    # the total amount of items matching the query
    attr_accessor :total
    # the current page
    attr_accessor :page
    # the amount of items you get per page
    attr_accessor :itemsPerPage

    # the json hash for this Result
    def to_jaxb_json_hash
      _h = {}
      _h['total'] = total.to_jaxb_json_hash unless total.nil?
      _h['page'] = page.to_jaxb_json_hash unless page.nil?
      _h['itemsPerPage'] = itemsPerPage.to_jaxb_json_hash unless itemsPerPage.nil?
      return _h
    end

    # the json (string form) for this Result
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Result with a json hash
    def init_jaxb_json_hash(_o)
      @total = Fixnum.from_json(_o['total']) unless _o['total'].nil?
      @page = Fixnum.from_json(_o['page']) unless _o['page'].nil?
      @itemsPerPage = Fixnum.from_json(_o['itemsPerPage']) unless _o['itemsPerPage'].nil?
    end

    # constructs a Result from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # This class represents an artist. An artist is a musician or a group of
  # musicians. Each artist has a definite <a
  # href="http://wiki.musicbrainz.org/MBID">Musicbrainz Identifier</a> (MBID)
  # with which the artist can be uniquely identified.
  class Artist

    # disambiguation to distinguish between artists with same names
    attr_accessor :disambiguation
    # unique Musicbrainz Identifier (MBID), e.g.
    # &lt;em&gt;&amp;quot;b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d&amp;quot;&lt;/em&gt;
    attr_accessor :mbid
    # unique Ticket Master Identifier (TMID), e.g. &lt;em&gt;1953&lt;/em&gt;
    attr_accessor :tmid
    # the artist's name, e.g. &lt;em&gt;&amp;quot;The Beatles&amp;quot;&lt;/em&gt;
    attr_accessor :name
    # the artist's sort name, e.g. &lt;em&gt;&amp;quot;Beatles, The&amp;quot;&lt;/em&gt; or
    # &lt;em&gt;&amp;quot;Springsteen, Bruce&amp;quot;&lt;/em&gt;
    attr_accessor :sortName
    # the attribution url
    attr_accessor :url

    # the json hash for this Artist
    def to_jaxb_json_hash
      _h = {}
      _h['disambiguation'] = disambiguation.to_jaxb_json_hash unless disambiguation.nil?
      _h['mbid'] = mbid.to_jaxb_json_hash unless mbid.nil?
      _h['tmid'] = tmid.to_jaxb_json_hash unless tmid.nil?
      _h['name'] = name.to_jaxb_json_hash unless name.nil?
      _h['sortName'] = sortName.to_jaxb_json_hash unless sortName.nil?
      _h['url'] = url.to_jaxb_json_hash unless url.nil?
      return _h
    end

    # the json (string form) for this Artist
    def to_json
      to_jaxb_json_hash.to_json
    end

    #initializes this Artist with a json hash
    def init_jaxb_json_hash(_o)
      @disambiguation = String.from_json(_o['disambiguation']) unless _o['disambiguation'].nil?
      @mbid = String.from_json(_o['mbid']) unless _o['mbid'].nil?
      @tmid = Fixnum.from_json(_o['tmid']) unless _o['tmid'].nil?
      @name = String.from_json(_o['name']) unless _o['name'].nil?
      @sortName = String.from_json(_o['sortName']) unless _o['sortName'].nil?
      @url = String.from_json(_o['url']) unless _o['url'].nil?
    end

    # constructs a Artist from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A Result consisting of a list of venues.
  class Venues < Fm::Setlist::Api::Model::Result

    # result list of venues
    attr_accessor :list

    # the json hash for this Venues
    def to_jaxb_json_hash
      _h = super
      if !list.nil?
        _ha = Array.new
        list.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['venue'] = _ha
      end
      return _h
    end

    #initializes this Venues with a json hash
    def init_jaxb_json_hash(_o)
      super _o
      if !_o['venue'].nil?
        @list = Array.new
        _oa = _o['venue']
        _oa.each { | _item | @list.push Fm::Setlist::Api::Model::Venue.from_json(_item) }
      end
    end

    # constructs a Venues from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A Result consisting of a list of setlists.
  class Setlists < Fm::Setlist::Api::Model::Result

    # result list of setlists
    attr_accessor :list

    # the json hash for this Setlists
    def to_jaxb_json_hash
      _h = super
      if !list.nil?
        _ha = Array.new
        list.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['setlist'] = _ha
      end
      return _h
    end

    #initializes this Setlists with a json hash
    def init_jaxb_json_hash(_o)
      super _o
      if !_o['setlist'].nil?
        @list = Array.new
        _oa = _o['setlist']
        _oa.each { | _item | @list.push Fm::Setlist::Api::Model::Setlist.from_json(_item) }
      end
    end

    # constructs a Setlists from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A Result consisting of a list of countries.
  class Countries < Fm::Setlist::Api::Model::Result

    # result list of countries
    attr_accessor :list

    # the json hash for this Countries
    def to_jaxb_json_hash
      _h = super
      if !list.nil?
        _ha = Array.new
        list.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['country'] = _ha
      end
      return _h
    end

    #initializes this Countries with a json hash
    def init_jaxb_json_hash(_o)
      super _o
      if !_o['country'].nil?
        @list = Array.new
        _oa = _o['country']
        _oa.each { | _item | @list.push Fm::Setlist::Api::Model::Country.from_json(_item) }
      end
    end

    # constructs a Countries from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A Result consisting of a list of cities.
  class Cities < Fm::Setlist::Api::Model::Result

    # result list of cities
    attr_accessor :list

    # the json hash for this Cities
    def to_jaxb_json_hash
      _h = super
      if !list.nil?
        _ha = Array.new
        list.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['cities'] = _ha
      end
      return _h
    end

    #initializes this Cities with a json hash
    def init_jaxb_json_hash(_o)
      super _o
      if !_o['cities'].nil?
        @list = Array.new
        _oa = _o['cities']
        _oa.each { | _item | @list.push Fm::Setlist::Api::Model::City.from_json(_item) }
      end
    end

    # constructs a Cities from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end

module Fm

module Setlist

module Api

module Model

  # A Result consisting of a list of artists.
  class Artists < Fm::Setlist::Api::Model::Result

    # result list of artists
    attr_accessor :list

    # the json hash for this Artists
    def to_jaxb_json_hash
      _h = super
      if !list.nil?
        _ha = Array.new
        list.each { | _item | _ha.push _item.to_jaxb_json_hash }
        _h['artist'] = _ha
      end
      return _h
    end

    #initializes this Artists with a json hash
    def init_jaxb_json_hash(_o)
      super _o
      if !_o['artist'].nil?
        @list = Array.new
        _oa = _o['artist']
        _oa.each { | _item | @list.push Fm::Setlist::Api::Model::Artist.from_json(_item) }
      end
    end

    # constructs a Artists from a (parsed) JSON hash
    def self.from_json(o)
      if o.nil?
        return nil
      else
        inst = new
        inst.init_jaxb_json_hash o
        return inst
      end
    end
  end

end

end

end

end
