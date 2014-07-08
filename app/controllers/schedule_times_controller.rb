class ScheduleTimesController < AccountsController
  before_action :set_schedule
  before_action :set_time, only: [:update, :destroy]

  def create
    @schedule.schedule_times.create(time: Time.now)
    schedule_times_response
  end

  def update
    if @time.update(time_params)
      schedule_times_response
    else
      flash[:error] = "BROKEN"
      schedule_times_response
    end
  end

  def destroy
    @time.destroy
    schedule_times_response
  end

  def schedule_times_response
    redirect_to schedules_path
  end

  private
  def set_schedule
    @schedule = current_user.schedules.find(params[:schedule_id])
  end

  def set_time
    @time = @schedule.schedule_times.find(params[:id])
  end

  def time_params
    params.require(:schedule_time).permit(:time)
  end
end