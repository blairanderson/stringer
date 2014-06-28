class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = current_user.feeds.map(&:stories).flatten.sort_by(&:published)
  end
end
