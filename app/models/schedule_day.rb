class ScheduleDay < ActiveRecord::Base
  belongs_to :day
  belongs_to :schedule
end
