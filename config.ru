require './application.rb'

set :bind, '0.0.0.0'

run Sinatra::Application
