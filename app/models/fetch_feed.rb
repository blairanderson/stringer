require "feedjira"

class FetchFeed
  attr_reader :feed
  USER_AGENT = "Stingerails (https://github.com/blairanderson)"

  def initialize(feed, parser = Feedjira::Feed)
    @feed = feed
    @parser = parser
  end

  def fetch
    begin
      raw_feed = @parser.fetch_and_parse(@feed.url, user_agent: USER_AGENT, if_modified_since: feed.last_fetched, timeout: 30, max_redirects: 2)

      if raw_feed == 304
        @logger.info "#{@feed.url} has not been modified since last fetch" if @logger
      else
        entries = new_entries_from(raw_feed)
        entries.each do |entry|
          Story.add(entry, feed)
        end

        feed.update_last_fetched(raw_feed.last_modified)
      end

      feed.green!
      feed.save
    rescue Exception => ex
      feed.red!
      feed.save

      @logger.error "Something went wrong when parsing #{feed.url}: #{ex}" if @logger
    end
  end

  private
  def new_entries_from(raw_feed)
    finder = FindNewStories.new(raw_feed, feed.last_fetched, latest_entry_id)
    finder.new_stories
  end

  def latest_entry_id
    return feed.stories.first.entry_id unless feed.stories.empty?
  end
end
