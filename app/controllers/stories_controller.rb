class StoriesController < AccountsController
  # TODO: figure out a good way to include the .user_stories with the stories
  # Would like to know if a user has read a given story. or favorited a given story.

  def index
    @stories = current_user.grouped_stories
  end
end
