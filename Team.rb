# Team.rb

require 'mongoid'
require 'tzinfo'

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
	field :location, type: String
	field :timezone, type: String
#	embedded_in :team
end
