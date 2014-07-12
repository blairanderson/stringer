class StoriesController < ApplicationController
  def index
    @stories = current_user.grouped_stories
  end

  def edit
    @story = current_user.stories.find(params[:id])
    content = [
        @story.strip_html(@story.title),
        @story.entry_id,
        @story.strip_html(@story.body)
    ].join(", ").html_safe
    @message = current_user.messages.build(content: content)
    render layout: false
  end
end
