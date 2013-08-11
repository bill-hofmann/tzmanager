# class: Team
require 'tzinfo'
require 'geonames'

class Team
  ##
  ## City where team is located
  ##    Time zone info for that city
  ## Work hours - wall clock time - an array of start and finish hours, 0..n
  ## Members of the team
  ## 
  attr_accessor :name, :timezone, :cityname, :tzinfo, :workhours, :members

  ## Class Variable
  @@default_workhours = [9..12, 13..18]

  def initialize(name, city, country, workhours = nil)
    @members = []
    @workhours = workhours || @@default_workhours
    @name = name

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

    self
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
        puts "lastr.last >= r.first - 1: #{lastr.last} >= #{r.first-1}"
        outages[-1] = lastr.first..[r.last, lastr.last].max
      else
        puts "else."
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
