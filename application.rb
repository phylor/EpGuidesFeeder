require 'sinatra'
require 'haml'

require_relative 'feed'

class ShowReference
  attr_accessor :id, :title
end

get '/' do
  haml :usage
end

get '/:name/:id' do
  feed = EpGuideFeed.new
  feed_result = feed.get_feed params[:name], params[:id].to_i, params[:q]

  feed_result.to_s
end

get '/search' do
  q = params[:q]

  shows = Array.new

  if q
    csvContent = open('public/data/allshows.txt', 'r:ISO-8859-1')

    #open from the web
    #htmlPage = Nokogiri::HTML(open(..))
    #htmlPage.xpath('//pre').each do |pre|
    #  csvContent = pre.content
    #  csvContent.strip!

    arr_of_arrs = CSV.parse(csvContent)
    arr_of_arrs.shift

    arr_of_arrs.each do |entry|
      title = entry[0]
      id = entry[2]

      if id and title
        if title.downcase.include?(q.downcase)
          show = ShowReference.new
          show.id = id
          show.title = title

          shows << show
        end
      end
    end


  end

  haml :search, :locals => { :shows => shows, :q => q }
end