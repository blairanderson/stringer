class Feeds::FetchFeeds
  def initialize(feeds)
    @feeds = feeds
  end

  def fetch_all
    @feeds.each do |feed|
      FetchFeed.new(feed).fetch
      ActiveRecord::Base.connection.close
    end
  end

  def self.enqueue(feeds)
    self.new(feeds).delay.fetch_all
  end
end
