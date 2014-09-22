require 'spec_helper'

describe ScheduleTracker do
  describe "validations" do
    it { should validate_presence_of :hour }
    it { should validate_presence_of :minute }
  end
end
