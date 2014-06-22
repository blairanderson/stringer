class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds rescue Feed.all
  end
end
