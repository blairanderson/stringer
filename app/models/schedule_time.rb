class ScheduleTime < ActiveRecord::Base
  belongs_to :schedule
  validates_presence_of :schedule_id, :time
end
