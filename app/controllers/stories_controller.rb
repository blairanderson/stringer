class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    # UserStory.new(user_id: current_user.id, story_id: story.id)
    @stories = current_user.feeds.map{|f| f.stories }.flatten.sort_by {|f| f.published}
  end
end
