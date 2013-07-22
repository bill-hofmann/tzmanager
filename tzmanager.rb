# tzmanager.rb
#

require 'sinatra'
require 'tzinfo'
require 'data_mapper' # metagem, requires common plugins too.
require 'Team'

get '/' do
	"Hello world!"
end

################################################################
#    Locations - read only layer atop tzinfo
#
get '/locations' do

end

get '/location/:id' do

end

################################################################
#    Teams - read/write
#
get '/teams' do

end

get '/team/:id' do

end

post '/team' do

end

put '/team/:id' do

end

delete '/team/:id' do

end


# end