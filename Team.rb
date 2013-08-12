# class: Team
require 'tzinfo'
require 'geonames'
require 'digest'

class Team
  ##
  ## City where team is located
  ##    Time zone info for that city
  ## Work hours - wall clock time - an array of start and finish hours, 0..n
  ## Members of the team
  ## 
  attr_accessor :id, :name, :timezone, :cityname, :tzinfo, :workhours, :members

  ## Class Variable
  @@default_workhours = [9..12, 13..18]
  @@sha256 = Digest::SHA256.new

  def initialize(name, city, country, workhours = nil)
    @members = []
    @workhours = workhours || @@default_workhours
    @name = name
    dig = @@sha256.digest "#{name}.#{city}.#{country}.#{Time.now}"
    @id = Digest::hexencode(dig)
    set_city city, country

    self
  end

  def set_city city, country
    sc = Geonames::ToponymSearchCriteria.new
    sc.name_starts_with = city
    sc.country_code = country
    sc.feature_codes = ['PPL']
    result = Geonames::WebService.search sc
    if result.toponyms.size > 0
      @city = result.toponyms.first.geoname_id
      @cityname = result.toponyms.first.name
      latitude = result.toponyms.first.latitude
      longitude = result.toponyms.first.longitude
      @timezone = Geonames::WebService.timezone latitude, longitude
      @tzinfo = TZInfo::Timezone.get(@timezone.timezone_id)
    else
      raise(ArgumentError, "City ${city} in ${country} Not Found")
    end
  end

  def add_member new_member
    @members = @members << new_member
  end

  def add_workhours hoursRange
    temp = @workhours.push(hoursRange)
    @workhours = merge_ranges(temp)
  end

  def merge_ranges(ranges)
    ranges = ranges.sort_by {|r| r.first }
    *outages = ranges.shift
    ranges.each do |r|
      lastr = outages[-1]
      if lastr.last >= r.first
        outages[-1] = lastr.first..[r.last, lastr.last].max
      else
        outages.push(r)
      end
    end
    outages
  end

  def local_to_utc(time)
    @tzinfo.local_to_utc(time)
  end
  def utc_to_local(time)
    @tzinfo.utc_to_local(time)
  end

end
