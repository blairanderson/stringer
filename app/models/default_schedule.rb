class DefaultSchedule
  attr_reader :schedule, :time
  def initialize(user)
    @schedule = user.schedules.create
    @time = @schedule.schedule_times.create(time: Time.now)
  end
end