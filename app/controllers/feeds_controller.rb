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
    feed = Feed.add(feed_params)

    if feed && current_user.feeds.include?(feed)
      redirect_to feed, notice: t('models.feed.exists')
    elsif feed
      current_user.feeds << feed
      redirect_to feed, notice: t('models.feed.created')
    else
      @feed = Feed.new
      flash[:error] = t('models.not_found')
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
