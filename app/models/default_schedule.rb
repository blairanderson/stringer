class DefaultSchedule
  def initialize(user)
    @schedule = user.schedules.create
    @schedule.schedule_times.create(time: Time.now)
  end
end