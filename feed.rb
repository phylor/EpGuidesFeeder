require 'nokogiri'
require 'open-uri'
require 'csv'
require 'rss'

class Show
  attr_accessor :season, :episode, :name, :date

  @season
  @episode
  @name
  @date

  def get_episode_string
    "S#{@season}E#{@episode}"
  end
end

class EpGuideFeed
  @shows

  def initialize
    @shows = Array.new
  end

  def get_feed(seriesName, epGuideId, queryParams)
    htmlPage = Nokogiri::HTML(open('http://www.epguides.com/common/exportToCSV.asp?rage='+epGuideId.to_s))
    
    htmlPage.xpath('//pre').each do |pre|
      csvContent = pre.content
      csvContent.strip!
    
      arr_of_arrs = CSV.parse(csvContent)
    
      arr_of_arrs.shift
    
      arr_of_arrs.each do |entry|
        season = entry[1]
        episode = entry[2]
        date = entry[4]
        name = entry[5]
    
        if date != 'UNAIRED' and season and episode and name
         show = Show.new
         show.season = "%02d" % season
         show.episode = "%02d" % episode
         show.date = date
         show.name = name
    
         @shows << show
        end
      end
    
      #todo: debug
      #shows.each do |show|
      #  print show.season, '/', show.episode, ': ', show.name, ' ', show.date
      #  puts
      #end
    
      rss = RSS::Maker.make("atom") do |maker|
        maker.channel.author = ''
        maker.channel.updated = Time.now.to_s
        maker.channel.about = ''
        maker.channel.title = seriesName
    
        @shows.each do |show|
          if Date.parse(show.date) <= Date.today

           maker.items.new_item do |item|
             item.link = "https://www.google.com/#q=#{URI::encode seriesName}+#{show.get_episode_string}+#{queryParams}"
             item.title = show.get_episode_string + ' ' + show.name
             item.updated = show.date
           end
          end
        end
      end

      return rss
    end
  end
end