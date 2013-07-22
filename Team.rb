# Team.rb

require 'mongoid'

class Team
    include Mongoid::Document
    field :owner						# a member
    field :name, type: String			# display name
    field :description, type: String	# description
    field :location, type: String		# city/etc.  Can be overridden at the member level
    field :timezone, type: String		# timezone info.  Can be overridden at the member level
    # need working/core hours here
    embeds_many :members				# team member
end

class Member
	include Mongoid::Document
	field :name, type: String
	field :email, type: String
	field :location, type: String		# if empty, defaults to team
	field :timezone, type: String		# if empty, defaults to team
	embedded_in :team
end
