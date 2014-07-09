class StoriesController < AccountsController
  def index
    @stories = current_user.grouped_stories
  end
end
