class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds
  end

  def new
    @feed = current_user.feeds.build
  end
end
