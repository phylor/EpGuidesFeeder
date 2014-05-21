require 'sinatra'
require 'haml'
require 'date'
require 'open-uri'

require_relative 'feed'

class ShowReference
  attr_accessor :id, :title
end

get '/' do
  redirect 'search'
end

get '/:name/:id' do
  feed = EpGuideFeed.new
  feed_result = feed.get_feed params[:name], params[:id].to_i, params[:q]

  feed_result.to_s
end

get '/search' do
  q = params[:q]
  search = params[:search]

  shows = Array.new

  if search
    filename = 'public/data/allshows.txt'
    file_exists = File.file?(filename)
    days_old = 1
    if file_exists
      days_old = (DateTime.now-File.mtime(filename).to_date).to_i
    end

    if(days_old > 0)
      document = open('http://epguides.com/common/allshows.txt')
      File.write(filename, document.read)
    end

    csvContent = open(filename, 'r:ISO-8859-1')



    arr_of_arrs = CSV.parse(csvContent)
    arr_of_arrs.shift

    arr_of_arrs.each do |entry|
      title = entry[0]
      id = entry[2]

      if id and title
        if title.downcase.include?(search.downcase)
          show = ShowReference.new
          show.id = id
          show.title = title

          shows << show
        end
      end
    end


  end

  haml :search, :locals => { :shows => shows, :q => q, :search => search }
end