class StoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stories = current_user.stories
  end
end
