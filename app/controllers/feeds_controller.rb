class FeedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_feed, only: [:show]

  def index
    @feeds = current_user.feeds
    FetchFeeds.new(@feeds).delay.fetch_all
  end

  def new
    @feed = current_user.feeds.build
  end

  def create
    @feed = Feed.add(feed_params)

    if @feed && current_user.feeds.include?(@feed)
      flash[:notice] = t('models.feed.exists')
      redirect_to_feed
    elsif @feed
      current_user.feeds << @feed
      flash[:notice] = t('models.feed.created')
      redirect_to_feed
    else
      @feed = Feed.new
      flash[:error] = t('models.not_found')
      render :new
    end
  end

  def redirect_to_feed
    FetchFeeds.new([@feed]).delay.fetch_all
    redirect_to @feed
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
