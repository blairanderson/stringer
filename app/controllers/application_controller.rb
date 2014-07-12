# This is the private application controller
# None of the public routes are handled with this controller.
# This is for the application.

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  around_filter :set_time_zone

  def set_time_zone
    if current_user
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end
end
