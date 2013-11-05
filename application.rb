require 'sinatra'
require 'haml'

require_relative 'feed'

get '/' do
  haml :usage
end

get '/:name/:id' do
  #feed = EpGuideFeed.new
  #puts feed.get_feed params[:name], params[:id].to_i
  #feed.get_feed 'hello', 8511

  feed = EpGuideFeed.new
  feed_result = feed.get_feed 'The Big Bang Theory', 8511

  feed_result.to_s
end
