require "feedbag"
require "feedjira"

class Feed < ActiveRecord::Base
  has_many :user_feeds
  has_many :users, through: :user_feeds
  has_many :stories

  validates_presence_of :url
  validates_uniqueness_of :url

  as_enum :status, [:green, :yellow, :red]

  def self.add(options = {})
    result = self.discover(options[:url])
    return false unless result

    last_fetched = Time.now - 1.month

    find_or_create_by(url: result.feed_url) do |f|
      f.name = result.title
      f.last_fetched = last_fetched
    end
  end

  def update_last_fetched(timestamp)
    if valid_timestamp?(timestamp, self.last_fetched)
      self.last_fetched = timestamp
      self.save
    end
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


  def valid_timestamp?(new_timestamp, current_timestamp)
    new_timestamp && new_timestamp.year >= 1970 && (current_timestamp.nil? || new_timestamp > current_timestamp)
  end
end
