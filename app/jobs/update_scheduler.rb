class UpdateScheduler
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def perform
    hour = time.hour
    minute = time.min
    tracker = ScheduleTracker.where(hour: hour, minute: minute).first_or_create
    unless tracker.completed_today?
      times = ScheduleTime.by_time(Time.now).select do |time|
        time.schedule.active_today?
      end

      times.each do |time|
        # This could become a background job eventually.
        MessageBuilder.new(time.user).perform
      end

      tracker.update(completed_at: Time.now)
    end
  end
end