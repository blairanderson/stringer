class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:update]
  before_action :require_day, only: [:update]

  def index
    @schedules = current_user.schedules.includes(:schedule_times)

    unless @schedules.present?
      DefaultSchedule.new(current_user)
      @schedules = current_user.schedules
    end
  end

  def update
    @schedule.toggle_day(@day)
    redirect_to schedules_path
  end

private

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def require_day
    day = params[:toggle].to_s.to_sym
    if Schedule::DAYS.include?(day)
      @day = day
    else
      render json: {message: "Not Found"}, status: :not_found
      return
    end
  end

end
