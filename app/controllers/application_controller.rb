# This is the private application controller
# None of the public routes are handled with this controller.
# This is for the application.

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # around_filter :set_time_zone

  # def set_time_zone
  #   if current_user
  #     Time.use_zone(current_user.time_zone) { yield }
  #   else
  #     yield
  #   end
  # end

  # TODO: create a before_action fo this method to confirm a user has confirmed their email address.
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
