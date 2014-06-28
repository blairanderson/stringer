class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = current_user.feeds.map(&:stories).flatten.sort_by(&:published).group_by do |g|
      g.published.to_s(:pretty_day_and_month)
    end
  end
end
