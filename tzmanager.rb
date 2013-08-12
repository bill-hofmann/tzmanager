# tzmanager.rb
#

require 'sinatra'
require 'tzinfo'
require 'mongoid'
require 'json'
require 'team'
require 'member'

teams = []
members = []

#Mongoid.load!("mongoid.yml")

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
  teams
end

get '/team/:id' do
  team = teams.select { |a| a.id == :id }
end

post '/team' do
  name = params[:name]
  city = params[:city]
  country = params[:country]
  workhours = params[:workhours] or nil
  team = Team.new(name, city, country, workhours)
  teams = teams << team

  team.id
end

put '/team/:id' do
  team = teams.select { |a| a.id = :id }
  return 403 if team == nil

  name = params[:name] or nil
  city = params[:city] or nil
  country = params[:country] or nil
  workhours = params[:workhours] or nil

  team.name = name unless name == nil
  team.workhours = workhours unless workhours == nil
  team.set_city city, country unless city == nil or country == nil

  team.id
end

delete '/team/:id' do
  teams = teams.reject! { |a| a.id == :id }

  200
end

################################################################
#    Member - read/write
#
get '/members' do
  members
end

get '/member/:id' do
  member = members.select { |a| a.id == :id }
end

post '/member' do
  name = params[:name]
  email = params[:email]
  associated_teams = params[:associated_teams] or nil
  member = Member.new(name, email, associated_teams)
  members = members << member

  member.id
end

put '/member/:id' do
  member = members.select { |a| a.id == :id }
  name = params[:name] or nil
  email = params[:email] or nil
  associated_teams = params[:associated_teams] or nil

  member.name = name unless name == nil
  member.email = email unless email == nil
  member.associated_teams = associated_teams unless associated_teams == nil

  member.id
end

delete '/member/:id' do
  members = members.reject! { |a| a.id == :id }

  200
end


# end