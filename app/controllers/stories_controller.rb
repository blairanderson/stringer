class StoriesController < AccountsController
  # TODO: figure out a good way to include the .user_stories with the stories
  # Would like to know if a user has read a given story. or favorited a given story.

  def index
    @stories = current_user.stories.includes(:user_stories).order(published: :desc).group_by do |g|
      g.published.to_s(:pretty_day_and_month)
    end
  end
end
