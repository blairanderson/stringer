class ScheduleTime < ActiveRecord::Base
  belongs_to :schedule
  validates_presence_of :schedule_id, :time

  scope :by_hour, ->(hour) { where("date_part('hour', time) = ?", hour) }
  scope :by_minute, ->(minute) {where("date_part('minute', time) = ?", minute) }
  scope :by_time, ->(time) { by_hour(time.hour).by_minute(time.minute) }
  scope :now, -> { by_time(Time.now) }

end
