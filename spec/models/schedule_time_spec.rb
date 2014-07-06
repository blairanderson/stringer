require 'spec_helper'

describe ScheduleTime do
  describe "validations" do
    it { should validate_presence_of :schedule_id }
    it { should validate_presence_of :time }
  end
end
