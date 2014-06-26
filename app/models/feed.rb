require "feedbag"
require "feedjira"

class Feed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, through: :user_feeds

  validates_presence_of :url
  validates_uniqueness_of :url

  def self.add(options = {})
    result = self.discover(options[:url])
    return false unless result

    self.find_or_create_by({
                               name: result.title,
                               url: result.feed_url
                           })
  end

  private
  def self.discover(url)
    @finder = Feedbag
    @parser = Feedjira::Feed
    get_feed_for_url(url) do
      urls = @finder.find(url)
      return false if urls.empty?

      get_feed_for_url(urls.first) do
        return false
      end
    end
  end

  def self.get_feed_for_url(url)
    feed = @parser.fetch_and_parse(url, user_agent: "Stringer")
    feed.feed_url ||= url
    feed
  rescue Exception
    yield if block_given?
  end
end
