class DefaultSchedule
  def initialize(user)
    @user = user
    @schedule = user.schedules.create
    Day.order(number: :desc).each do |d|
      ScheduleDay.create(schedule_id: @schedule.id, day_id: d.id)
    end
  end
end