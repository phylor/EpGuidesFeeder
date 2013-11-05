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
end

shows = Array.new

htmlPage = Nokogiri::HTML(open('http://www.epguides.com/common/exportToCSV.asp?rage=8511'))

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

    if date != 'UNAIRED'
     show = Show.new
     show.season = season
     show.episode = episode
     show.date = date
     show.name = name

     shows << show
    end
  end

  #shows.each do |show|
  #  print show.season, '/', show.episode, ': ', show.name, ' ', show.date
  #  puts
  #end

  rss = RSS::Maker.make("atom") do |maker|
    maker.channel.author = "meta"
    maker.channel.updated = Time.now.to_s # should be newest date from CSV
    maker.channel.about = 'http://nyi.ch'
    maker.channel.title = 'Episodes'

    shows.each do |show|
       maker.items.new_item do |item|
         item.link = 'http://nyi.ch'
         item.title = show.name
         item.updated = show.date
       end
    end
  end

  puts rss
end
