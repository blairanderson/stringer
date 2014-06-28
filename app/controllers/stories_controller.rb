class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    # UserStory.new(user_id: current_user.id, story_id: story.id)
    @stories = current_user.feeds.map(&:stories).flatten.sort_by(&:published)
  end
end
