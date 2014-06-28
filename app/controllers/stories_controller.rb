class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = current_user.feeds.map(&:stories).flatten.sort_by(&:published).group_by do |g|
      "#{g.published.day} #{g.published.month}"
    end
  end
end
