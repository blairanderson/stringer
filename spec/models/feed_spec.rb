require 'spec_helper'

describe Feed do
  describe "Validations" do
    before { create(:feed) }
    it { should validate_uniqueness_of :url }
    it { should validate_presence_of :url }
  end

  describe "associations" do
    it { should have_many :user_feeds }
    it { should have_many(:users).through(:user_feeds) }
    it { should have_many(:stories) }
  end

  describe "feed cannot be discovered" do
    let(:discoverer) { double(discover: false) }
    it "returns false if cant discover any feeds" do
      result = Feed.add({url: "http://not-a-feed.com"})
      expect(result).to be_false
    end
  end

  describe "feed can be discovered" do
    let(:url) { "http://quickleft.com/blog.rss" }
    it "parses and creates the feed if discovered" do
      result = Feed.add({url: url})
      expect(result).to be_valid
      expect(result.url).to eq url
    end
  end

  describe "#update_last_fetched" do
    let(:timestamp) { Time.now }

    it "saves the last_fetched timestamp" do
      feed = create(:feed)

      feed.update_last_fetched(timestamp)

      expect(feed.last_fetched).to eq timestamp
    end

    let(:weird_timestamp) { Time.parse("Mon, 01 Jan 0001 00:00:00 +0100") }
    it "rejects weird timestamps" do
      feed = create(:feed, last_fetched: timestamp)

      feed.update_last_fetched(weird_timestamp)

      expect(feed.last_fetched).to eq timestamp
    end

    it "doesn't update if timestamp is nil (feed does not report last modified)" do
      feed = create(:feed, last_fetched: timestamp)

      feed.update_last_fetched(nil)

      expect(feed.last_fetched).to eq timestamp
    end

    it "doesn't update if timestamp is older than the current value" do
      feed = create(:feed, last_fetched: timestamp)
      one_week_ago = timestamp - 1.week

      feed.update_last_fetched(one_week_ago)

      expect(feed.last_fetched).to eq timestamp
    end
  end
end
