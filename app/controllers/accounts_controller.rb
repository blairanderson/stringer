class AccountsController < ApplicationController
  before_action :authenticate_user!


  # around_filter :set_time_zone
  #
  # def set_time_zone
  #   if logged_in?
  #     Time.use_zone(current_user.time_zone) { yield }
  #   else
  #     yield
  #   end
  # end
end