class StoriesController < ApplicationController
  def index
    @stories = current_user.grouped_stories
  end

  def show
    @story = Story.find(params[:id])
  end

  def edit
    story = Story.find(params[:id])
    content = [
        story.strip_html(story.title)," - ",
        story.entry_id," - ",
        story.strip_html(story.body).truncate(50)
    ].join("").html_safe
    @message = current_user.messages.build(content: content)
    render layout: "message_form"
  end
end
