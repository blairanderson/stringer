class FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feed, only: [:show]
  
  def index
    @feeds = current_user.feeds
  end

  def new
    @feed = current_user.feeds.build
  end

  def create
    feed = Feed.where(feed_params).first
    if (feed && feed.valid?)
      flash[:notice] = t("models.feed.created")
      @feed = feed
    else
      @feed = Feed.add(feed_params)
    end

    if @feed
      current_user.feeds << @feed
      redirect_to @feed, notice: "Feed Created!"
    else
      @feed = current_user.feeds.build(feed_params)
      flash[:notice] =  "Could not be found."
      render :new
    end
  end

  def show
  end

  private
  def feed_params
    params.require(:feed).permit(:url)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
