class SchedulesController < AccountsController
  def index
    @schedules = current_user.schedules.includes(schedule_days: [:days])

    unless @schedules.present?
      DefaultSchedule.new(current_user)
      @schedules = current_user.schedules
    end
  end
end
