class UserTimeZonesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    if current_user.update(timezone_params)
      redirect_to edit_user_time_zone_path
    else
      render :edit
    end
  end

  def timezone_params
    params.require(:user).permit(:time_zone)
  end
end
