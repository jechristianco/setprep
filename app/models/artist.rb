class Artist

  DATA_FOLDER = "2015-07-05--02-10-46"

  attr_accessor :name, :small

  def self.each_from_file
    [*('a'..'z')].each do |letter|
      File.open("./data/#{DATA_FOLDER}/#{letter}.txt", "r") do |f|
        f.each_line do |line|
          if !line.empty?
            if !line.index('(').nil?
              line = line.split('(', 2)
              yield Artist.new(name: line[0].strip, small: line[1].chomp(")\n"))
            else
              yield Artist.new(name: line)
            end
          end
        end
      end
    end
  end

  def self.scrape
    mechanize = Mechanize.new
    folder_name = Time.now.strftime("%Y-%m-%d--%H-%M-%S")
    Dir.mkdir "./data/#{folder_name}"
    [*('a'..'z')].each do |letter|
      content = ""
      count = 1
      reached_end = false
      while !reached_end
        url = "http://www.setlist.fm/artist/browse/#{letter}/#{count}.html"
        10.times do |i|
          begin
            doc = mechanize.get(url).parser
            doc.css('table.artistBrowseList td > span > a').each do |node|
              title = node.attribute('title').value
              if node.ancestors('td').css('small').empty?
                content << title[5, title.length - 14] + "\n"
              else
                content << title[5, title.length - 14] + " " + node.ancestors('td').css('small').text + "\n"
              end
            end
            break
          rescue Mechanize::ResponseCodeError, Net::HTTPNotFound
            reached_end = true if i == 9
          end
        end
        count += 1
      end
      File.write("./data/#{folder_name}/#{letter}.txt", content)
      puts "Wrote #{letter}.txt"
    end
  end

  def initialize(args={})
    @name = args[:name]
    @small = args[:small]
  end

  def full_description
    if small != nil
      "#{name} (#{small})"
    else
      name
    end
  end

end
