# class: Member

require 'digest'

class Member
  ## A member can be a member of 0..n teams
  ## A member can associate (but not necessarily be a member of) 0..n teams
  ## 
  ##    !!!!TODO: allow member-specific locations/times
  ##
  attr_accessor :id, :name, :email, :associated_teams
  @@sha256 = Digest::SHA256.new

  def initialize(member_name, member_email, associated_teams = nil)
    dig = @@sha256.digest "#{member_name}.#{member_email}.#{Time.now}"
    @id = Digest::hexencode(dig)
    @name = member_name or raise ArgumentError, 'Must name a member'
    @email = member_email or raise ArgumentError, 'Must provide member email'
    raise ArgumentError, "Malformed email: '#{member_email}'" unless member_email =~ /\S+@\S+\.\S{2,}/
    @associated_teams = associated_teams or []
  end
end
