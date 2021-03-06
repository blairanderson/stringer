require 'spec_helper'

describe Schedule do

  describe "validations" do
    subject { Schedule.new }
    it "is invalid without a schedule_time"
    it "not invalid with at least one schedule time"
  end

  describe "associations" do
    it { should belong_to :user }
    it { should have_many :schedule_times }
  end

  describe ".today" do
    it 'returns all schedules that are active today' do
      # This stubs today and returns a FRIDAY
      Date.stub(:today).and_return(Date.new(2011, 11, 11))

      schedule = create(:schedule, friday: :inactive)
      expect(Schedule.today.first).to be_nil

      schedule.update(friday: :active)
      expect(Schedule.today.first).to eq(schedule)
    end
  end
  describe "days" do
    it "should require days to be enums"
  end

  describe "#toggle" do
    it "flips a day from active to inactive" do
      expect(subject.monday).to be(:active)
      subject.toggle_day(:monday)
      expect(subject.monday).to be(:inactive)
    end

    it "flips a day from inactive to active" do
      subject.toggle_day(:tuesday)

      expect(subject.tuesday).to be(:inactive)
      subject.toggle_day(:tuesday)
      expect(subject.tuesday).to be(:active)
    end
  end
end
