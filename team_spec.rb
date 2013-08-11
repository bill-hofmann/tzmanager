require 'team'
require 'tzinfo'

describe Team do
  it "correctly converts to gmt" do
    team = Team.new("Red Team", 'New York', 'US')
    now = team.timezone.now
    utc = TZInfo::Timezone.get('GMT')

    team.convert_to_gmt(now).should eq(utc)
  end
end

describe Team do
  it "correctly converts to local time" do
    team = Team.new("Blue Team", 'San Francisco', 'US')
    now = team.timezone.now
    utc = TZInfo::Timezone.get('GMT')

    team.convert_to_local(utc).should eq(utc)
  end
end

describe Team do
  it "lets you add members" do
    team = Team.new("Orange Team", 'Los Angeles', 'US')
    mem1 = Member.new("Dave")
    team.add_member(mem1)
    mem2 = Member.new("Sally")
    team.add_member(mem2)


  end
end

