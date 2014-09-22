class UpdateScheduler
  attr_reader :time

  def initialize(time)
    @time = time
  end

  def perform
    hour = time.hour
    minute = time.min
    tracker = ScheduleTracker.where(hour: hour, minute: minute).first_or_create
    if tracker.completed_today?
      times = ScheduleTime.by_time(Time.now).select do |time|
        time.schedule.active_today?
      end
      times.each do |time|
        puts "create a message for user: #{time.user.inspect}"
        # Messenger.new(time.user.id).delay.perform
      end
    end
  end
end