require "feedbag"
require "feedjira"

class Feed < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :user_feeds
  has_many :users, through: :user_feeds

  validates_presence_of :url

  ONE_DAY = 24 * 60 * 60
  def self.add(options = {})
    result = self.discover(options[:url])
    return false unless result

    return create({
        name: result.title,
        url: result.feed_url,
        last_fetched: Time.now - ONE_DAY
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
