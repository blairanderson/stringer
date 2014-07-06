class ScheduleTimesController < AccountsController
  before_action :set_schedule

  def create
    @schedule.schedule_times.create(time: Time.now)
    redirect_to schedules_path
  end

  def destroy
  end

  private
  def set_schedule
    @schedule = current_user.schedules.find(params[:schedule_id])
  end
end