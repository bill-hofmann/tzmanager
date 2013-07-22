# Team.rb

require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Team
    include DataMapper::Resource
    property :id, Serial
    property :name, String
    property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the table
Team.auto_upgrade!
