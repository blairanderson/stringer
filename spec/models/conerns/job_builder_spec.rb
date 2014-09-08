require 'spec_helper'

describe JobBuilder do

  it "requires the schedule days to be correct and in order" do
    expect(Schedule::DAYS[0]).to eq :sunday
    expect(Schedule::DAYS[1]).to eq :monday
    expect(Schedule::DAYS[2]).to eq :tuesday
    expect(Schedule::DAYS[3]).to eq :wednesday
    expect(Schedule::DAYS[4]).to eq :thursday
    expect(Schedule::DAYS[5]).to eq :friday
    expect(Schedule::DAYS[6]).to eq :saturday
  end

  it 'should find all the schedules for today' do
    monday = {
        cd: "monday_cd",
        wday: 1 # we find the day using Date.today.wday passed into an arary of days
    }

    date = Object.new
    Date.stub(:today).and_return(date)

    date.stub(:wday).and_return(monday[:wday])

    Schedule.should_receive(:where).with({monday[:cd]=>0})
    JobBuilder.new
  end

  it 'should find schedule_times for a given minute' do
    user = create(:user)
    sched_builder = DefaultSchedule.new(user)
    expect(JobBuilder.new.times).to include sched_builder.time
  end

  it "creates a job for a given user and time" do
    
  end
end