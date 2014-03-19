require 'sinatra'
require 'haml'

require_relative 'feed'

get '/' do
  haml :usage
end

get '/:name/:id' do
  feed = EpGuideFeed.new
  feed_result = feed.get_feed params[:name], params[:id].to_i, params[:q]

  feed_result.to_s
end
