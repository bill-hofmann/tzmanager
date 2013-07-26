# tzmanager.rb
#

require 'sinatra'
require 'tzinfo'
#require 'Team'
require 'mongoid'
require 'json'

Mongoid.load!("mongoid.yml")

class Member
  include Mongoid::Document
  field :name
  field :email
  field :location
  field :timezone
  # field :name, type: String
  # field :email, type: String
  # field :location, type: String
  # field :timezone, type: String
# embedded_in :team
end


################################################################
#    Locations - read only layer atop tzinfo
#
get '/locations' do

end

get '/location/:id' do

end

################################################################
#    Timezones - read only layer atop tzinfo
#
get '/timezones' do
	tz = TZInfo::Timezone.all()
	tzh = Hash.new
	tz.each do |i|
		tzh[i.identifier()] = i.friendly_identifier(false)
	end
	JSON.pretty_generate tzh
end

get '/timezone/:id' do
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

################################################################
#    Member - read/write
#
get '/members' do

end

get '/member/:id' do

end

post '/member' do
  # member = Member.new name: 'Bill', email: 'bill.hofmann@gmail.com', location: 'Berkeley', timezone: 'Americas/Los Angeles' 
  member = Member.new
  member.name = 'Bill'
  member.email = 'bill.hofmann@gmail.com'
  member.location = 'Berkeley'
  member.timezone = 'Americas/Los Angeles'
  member.save
  member._id
end

put '/member/:id' do

end

delete '/member/:id' do

end


# end